
# Copyright (c) 2018-2021, Carnegie Mellon University
# See LICENSE for details

#dummy var to keep copyright out of doc string
_dummy := 0;


TimeRec := (i,m) -> rec(index := i, measured := m);

IsTimeRec := r -> IsRec(r) and IsBound(r.index) and IsBound(r.measured);


#F TimeRuleTrees(spl, opts, treenums)
#F
#F    Times each rule tree indexed in list and returns a list of records
#F    spl      - SPL object to build rule trees from
#F    opts     - options
#F    treenums - list of integer indexes to rule trees for SPL object
#F               Must all be from 1 to NofRuleTrees(SPL, obj)
#F
#F	  TimeRec records in returned list of form:
#F    {
#F      index    := <integer, index of tree>,
#F      measured := <float, measured timing value, typically cycles>
#F    }
#F
#F    if opts.timingResultsFile is set, prints results to file

TimeRuleTrees := function(spl, opts, treenums)
	local retlist, idx, tree, meas, verbosity, maxidx, toFile, resultsFile, mem;

	# validate args
	if (not IsSPL(spl)) or (not IsRec(opts)) or (not IsList(treenums)) then
		Error("usage: TimeRuleTrees(spl, opts, treenums)");
	fi;
	
	# validate list of indexes
	maxidx := NofRuleTrees(spl, opts);
	if not ForAll(treenums, x -> IsInt(x) and x > 0 and x <= maxidx) then
		Error("List of tree indexes must be in range 1..<number of trees for spl>");
	fi;
	
	verbosity := Cond(IsBound(opts.verbosity), opts.verbosity, 0);
	
	if verbosity > 0 then
		Print("Timing ", Length(treenums), " rule trees\n");
	fi;
	
	toFile := IsBound(opts.timingResultsFile) and IsString(opts.timingResultsFile);
	if toFile then
		resultsFile := opts.timingResultsFile;
		AppendTo(resultsFile, "# Timing results for ", spl, "\n\n");
	fi;	
	
	retlist := [];
	for idx in treenums do
		tree := RuleTreeN(spl, idx, opts);
		if tree <> false then
			meas := CMeasureRuleTree(tree, opts);
			Add(retlist, TimeRec(idx, meas));
			if verbosity > 1 then
				Print(idx, ": ", meas, "\n");
			fi;
			if toFile then
				AppendTo(resultsFile, idx, ", ", meas, "\n");
			fi;
		fi;
		
		ResetCodegen();
	od;
	return retlist;
end;


#F BestTimedRuleTree(reclist)
#F
#F    Finds the TimeRec in reclist with the best time
#F    reclist - list of timing records as returned by TimeRuleTrees
#F
#F	  Returns a copy of the best TimeRec

BestTimedRuleTree := function(reclist)
	local bestRec, tmRec;
	
	# validate list of timing records
	if not ForAll(reclist, r -> IsTimeRec(r)) then
		Error("reclist is not a valid list of timing records");
	fi;
	
	bestRec := reclist[1];
	for tmRec in reclist do
		if tmRec.measured < bestRec.measured then
			bestRec := tmRec;
		fi;
	od;
	
	return Copy(bestRec);
end;


#F StridedList(from, to, count)
#F
#F   Returns a list of <count> integers evenly spaced from <from> to <to>.
#F
#F   If the count is greater than <from>..<to> returns [from..to]

StridedList := function(from, to, count)
	local len, stride, retlist;

	to := Maximum(from, to);
	
	len := (to - from) + 1;
	if (count >= len) then
		return List([from..to]);
	fi;
	
	stride := len / (count - 1);
	retlist := List([0..(count - 2)], x -> from + Int(x * stride));
	Add(retlist, to);

	return retlist;
end;


#F TimeStridedRuleTrees(spl, opts, sample_count)
#F
#F    Time a <sample_count> long list of indexed rule trees,
#F    evenly spaced from tree 1 through the last last tree.
#F
#F    Returns a list of timing records (TimeRec)

TimeStridedRuleTrees := function(spl, opts, sample_count)
	local n_trees, stride, index_list;
	
	if sample_count < 1 then
		Error("<sample_count> must be greater than 0");
	fi;

	n_trees := NofRuleTrees(spl, opts);
	index_list := StridedList(1, n_trees, sample_count);

	return TimeRuleTrees(spl, opts, index_list);
end;


