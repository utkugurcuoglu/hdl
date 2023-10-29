module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

parameter state_A = 0, state_B = 1, state_C = 2;

reg [1:0] state, next_state;

always @(state or In1)
begin : next_sate_logic
 case(state)
  state_A: 
  begin
   if(In1) next_state = state_B;
   else next_state = state_A;
  end

  state_B: 
  begin
   if(!In1) next_state = state_C;
   else next_state = state_B;
  end

  state_C: 
  begin
   if(In1) next_state = state_A;
   else next_state = state_C;
  end

  default:
   next_state = state_A; 
 endcase
end

always @(posedge CLK or negedge RST)
begin : register_generation
 if(RST) state = state_A;
 else state = next_state;
end

always @(state)
begin : output_logic
 case(state)
  state_A: Out1 = 0;
  state_B: Out1 = 0;
  state_C: Out1 = 1;
  default: Out1 = 0; 
 endcase
end

endmodule


