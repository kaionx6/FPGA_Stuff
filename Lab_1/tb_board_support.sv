`timescale 1ns / 1ps
module tb_board_support;
    reg clk100=0, pressed=1;
    reg [5:0] sw=0;
    wire [7:0] ndigit,nsegment,bsegment0,bsegment1;
    wire [3:0] bdigit0,bdigit1;
    always #5 clk100=~clk100;
    displayTestNexys #(.SLOT_CYCLES(8)) nexys (
        .clk100(clk100),.rstPBn(~pressed),.sw(sw),.digit(ndigit),.segment(nsegment));
    displayTestBoolean #(.SLOT_CYCLES(8)) boolean_board (
        .clk100(clk100),.rstPB(pressed),.sw(sw),.digit0(bdigit0),.digit1(bdigit1),
        .segment0(bsegment0),.segment1(bsegment1));
    reg [7:0] map_digit=8'hFF,map_segment=8'hFF;
    wire [3:0] ad0,ad1,sd0,sd1;
    wire [7:0] as0,as1,ss0,ss1;
    boolean_display_adapter normal_map(map_digit,map_segment,ad0,ad1,as0,as1);
    boolean_display_adapter #(.SWAP_BANKS(1)) swapped_map(map_digit,map_segment,sd0,sd1,ss0,ss1);
    function automatic [6:0] expected_pattern(input integer pos);
        case(pos)
            0: expected_pattern=7'h24; // 5
            1: expected_pattern=7'h4C; // 4
            2: expected_pattern=7'h06; // 3
            3: expected_pattern=7'h12; // 2
            4: expected_pattern=7'h4F; // 1
            default: expected_pattern=7'h7F;
        endcase
    endfunction
    integer d,s,i,pos,active,checks=0;
    reg [4:0] seen=0;
    realtime previous_edge=0;
    task check_frame(input [4:0] dot_mask);
        begin
            seen=0;
            repeat(50) begin
                @(posedge nexys.board_core.clk5); #1;
                if(previous_edge!=0 && (($realtime-previous_edge < 199.98) || ($realtime-previous_edge > 200.02)))
                    $fatal(1,"5 MHz clock period wrong");
                previous_edge=$realtime;
                if(ndigit!=={bdigit1,bdigit0} || nsegment!==bsegment0 || nsegment!==bsegment1)
                    $fatal(1,"Board wrappers disagree");
                active=0; pos=-1;
                for(i=0;i<8;i=i+1) if(ndigit[i]===1'b0) begin active=active+1; pos=i; end
                if(active>1) $fatal(1,"Multiple digits lit");
                if(pos>=5) $fatal(1,"Unused digit lit");
                if(pos>=0) begin
                    seen[pos]=1;
                    if(nsegment[7:1]!==expected_pattern(pos) || nsegment[0]!==~dot_mask[pos])
                        $fatal(1,"Wrong number or dot at position %0d",pos);
                end
                checks=checks+1;
            end
            if(seen!==5'b11111) $fatal(1,"Not all five digits scanned");
        end
    endtask
    initial begin
        // Exhaust all input combinations, including blank/invalid digit masks.
        for(d=0;d<256;d=d+1) for(s=0;s<256;s=s+1) begin
            map_digit=d; map_segment=s; #1;
            if({ad1,ad0}!==map_digit || {sd0,sd1}!==map_digit)
                $fatal(1,"Bank mapping error");
            if(as0!==map_segment || as1!==map_segment || ss0!==map_segment || ss1!==map_segment)
                $fatal(1,"Segment duplication error");
        end
        #17; pressed=0;
        wait(nexys.board_core.reset===1'b0 && boolean_board.board_core.reset===1'b0);
        repeat(20) @(posedge nexys.board_core.clk5);
        check_frame(5'b00000);
        sw=6'b101011;
        repeat(50) @(posedge nexys.board_core.clk5);
        previous_edge=0;
        check_frame(5'b11011);
        #17; pressed=1; #2;
        if(ndigit!==8'hFF || nsegment!==8'hFF || {bdigit1,bdigit0}!==8'hFF)
            $fatal(1,"Board reset does not blank outputs");
        #513; pressed=0;
        wait(nexys.board_core.reset===1'b0 && boolean_board.board_core.reset===1'b0);
        repeat(50) @(posedge nexys.board_core.clk5);
        previous_edge=0;
        check_frame(5'b11011);
        $display("PASS tb_board_support: 65536 adapter combinations and %0d scan checks",checks);
        $finish;
    end
    initial begin #2000000; $fatal(1,"Timeout"); end
endmodule
