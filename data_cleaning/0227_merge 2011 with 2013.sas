/*========================================*/
/*		   merge 2011 with 2013			  */
/*========================================*/

/*========================================*/
/** Check dataset if they have same variable names */

/** Economic characterstics **/
/*   -> ok                   */

/** Grocerystore            **/

proc contents data=snaped.grocery2011;run;
proc contents data=snaped.grocery2013;run;
data new;
	merge snaped.grocery2011 snaped.grocery2013;
	run;
proc contents data=new; run;
proc print data=new;run;