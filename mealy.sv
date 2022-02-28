module seq_10110_mealy (input din, clk, rst,
                output reg dout, reg count1, reg count2);
  
  // Parameterized state values for ease
  parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4=4;
  parameter S0_2 = 0, S1_2 = 1, S2_2 = 2, S3_2 = 3, S4_2=4;
   parameter S0_3 = 0, S1_3 = 1, S2_3 = 2, S3_3 = 3, S4_3=4;
  parameter bits = 5; 
	parameter count_bits = 4; 
	parameter pattern = 5'b10110; 
 
  
  // RState memory definition
  reg [2:0] state, next_state;
  wire detected; 
	 
  // Next State Logic - combinational logic to compute the next state based on the current state and input value
  always_comb @ (din,state) begin
    case (state)
      S0: next_state = din ? S1 : S0;
      S1: next_state = din ? S1 : S2;
      S2: next_state = din ? S3 : S0;
      S3: next_state = din ? S4 : S2;
	  S4: next_state = din ? S1 : S0;	  
      default: next_state = S0;
    endcase
  end
  
  // State Memory - Assign the computed next state to the state memory on the clock edge
  always_ff @ (posedge clk) begin
    if (rst) state <= 2'b00;
    else state <= next_state;
  end
  
  // Output functional logic - The states for which the output should be '1'
  always_comb @ (posedge clk) begin
    if (rst) begin
	dout <= 1'b0;
	detected1 <= 1'b0;
    else begin
      if (!din & (state == S4)) dout <= 1'b1;
	  if (!din & (state == S4_2)) dout <= 1'b1;
	  if (din & (state == S4_3)) dout <= 1'b1;
      else dout <= 1'b0;
    end
  end
  /////////////////////////////////////////////////////////////////////
  always_ff @ (posedge clk) begin
	if (rst && S4) begin 
		count1 <= 0;
	end
	else 
	begin
	if(count<10)
	begin
		count1 <= count1 +1
	end
	else begin 
	count1 <= 0;
	end
	end
	end
///////////////////////////////////////////////////////////////////////
  always_ff @ (posedge clk) begin
	if (rst && S4_2) begin 
		count2 <= 0;
	end
	else 
	begin
	if(count2<10)
	begin
		count2 <= count2 +1
	end
	else begin 
	count2 <= 0;
	end
	end
	end
  /////////////////////////////////////////////////////////////////////
  always_comb @ (din && state && S4) begin
    case (state)
      S0_2: next_state = din ? S1_2 : S0_2;
      S1_2: next_state = din ? S1_2 : S2_2;
      S2_2: next_state = din ? S3_2 : S0_2;
      S3_2: next_state = din ? S4_2 : S2_2;
	  S4_2: next_state = din ? S1_2 : S0_2;	  
      default: next_state = S0_2;
    endcase
  end
/////////////////////////////////////////////////////////////////////////////
	  always_comb @ (din && state && S4_2) begin
    case (state)
      S0_3: next_state = din ? S1_3 : S0_3;
      S1_3: next_state = din ? S1_3 : S2_3;
      S2_3: next_state = din ? S3_3 : S0_3;
      S3_3: next_state = din ? S4_3 : S2_3;
	  S4_3: next_state = din ? S1_3 : S0_3;	  
      default: next_state = S0_3;
    endcase
  end
  /////////////////////////////////////////////////////////////////////
endmodule