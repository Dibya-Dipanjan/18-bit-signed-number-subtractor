// Here (a - b) is performed
module subtractor(clk , rst , a , b, z);

input clk,rst;
input [17:0] a,b;
output reg[18:0] z;

reg [3:0] state;

reg [16:0] a_magnitude, b_magnitude;
reg [17:0] z_magnitude;
reg a_sign,b_sign;
reg z_sign;

always @(posedge clk or rst) begin
	if(rst)
		state<= 0;
	else
		state <= state + 1;
end

always @(state) begin
if(state == 4'b0001) begin
	   a_magnitude = a[16:0];
	   a_sign = a[17];
	   b_magnitude = b[16:0];
	   b_sign = b[17];
	   z_magnitude = z[17:0];
	   z_sign = z[18];
	end
end

always @(state) begin
if(state == 4'b0010)begin
	if((a_sign == 0 && b_sign == 0) && (a_magnitude > b_magnitude)) begin
	z[18] = 0;
	z[17:0] = a_magnitude - b_magnitude;
        end
    end
end

always @(state) begin
	if(state == 4'b0011) begin
		if((a_sign == 0 && b_sign == 0) && (a_magnitude < b_magnitude)) begin
			z[18] = 1;
			z[17:0] = b_magnitude - a_magnitude;
			end
	end
end		
                    

always @(state) begin
		if(state == 4'b0100) begin
			if((a_sign == 0 && b_sign == 1)) begin
				z[18] = 0;
				z[17:0] = a_magnitude + b_magnitude;
				end
		end
end

always @(state) begin
		if(state == 4'b0101) begin
			if((a_sign == 1 && b_sign == 0)) begin
				z[18] = 1;
				z[17:0] = a_magnitude + b_magnitude;
				end
		end
end

always @(state) begin
if(state == 4'b0110)begin
	if((a_sign == 1 && b_sign == 1) && (a_magnitude > b_magnitude)) begin
		z[18] = 1;
		z[17:0] = a_magnitude - b_magnitude;
        end
    end
end

always @(state) begin
	if(state == 4'b0111) begin
		if((a_sign == 1 && b_sign == 1) && (a_magnitude < b_magnitude)) begin
			z[18] = 0;
			z[17:0] = b_magnitude - a_magnitude;
			end
	end
end

always @(state) begin
	if(state == 4'b1001) begin
		if((a_sign == b_sign) && (a_magnitude == b_magnitude))begin
			z[18] = 0;
			z[17:0] = 0;
		end
	end
end	

always @(state) begin
	if(state == 4'b1000)begin
		z_sign = z[18];
		z_magnitude = z[17:0];
	end
end	


endmodule	

		
				