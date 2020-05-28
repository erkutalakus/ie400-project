/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Emir Ozturk, Erkut Alakus, Omer Faruk Oflaz
 * Creation Date: 5 May 2020 at 00:14:10
 *********************************************/
int n = ...;
range range_ = 1..n;
int Distance[range_][range_] = ...;
int Time[range_] = ...;
float start;
execute{
var before = new Date();
start = before.getTime();
}

/******************************************************************************
 * MODEL DECLARATIONS
 ******************************************************************************/
dvar int  Binary[range_][range_] in 0..1;

/******************************************************************************
 * MODEL
 ******************************************************************************/
dexpr float Objective =(sum(i,j in range_) Binary[i][j]*(Distance[i][j] + Time[j]));

minimize Objective;
dvar int+ u[2..n];
subject to{
      forall (j in range_)
          flow_in:
         sum (i in range_ : i!=j) Binary[i,j] == 1;

      forall (i in range_ )
        flow_out:
        sum (j in range_ : j!=i) Binary[i,j] == 1;

		forall (i in range_ : i>1, j in range_ : j>1 && j!=i)
			prevnt_multiple_loop:
			u[i]-u[j]+(n-1)*Binary[i,j]<=n-2;
  }

execute DISPLAY {
	var after = new Date();
	var check = false;
	var i = 1;
	write(1 + " -> ");
	for(var j = 1; (!check || i!= 1) && j<=n; j++ ){
		if (Binary[i][j] == 1) {
			check = true;
			i = j;
			write(i + " -> ");
			j = 1;
		}		
	}
	
	writeln("1");  	
	writeln("Total Time: ", Objective);
	writeln("Solving Time = ", after.getTime()-start);
}
 