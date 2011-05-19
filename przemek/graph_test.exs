object GraphTest
  proto ExUnit::Case

  def initialize_test
		graph = Graph.new
		{:} = graph.g
		{:} = graph.d
		true = (Erlang.bsl(1,32) == graph.max_int)
  end
  
  def add_edge_test
		graph = Graph.new
		graph = graph.add_edge('s, 't, 10)
		
		%% distance equal 2^32
		true = (Erlang.bsl(1,32) == graph.d['s])
		true = (Erlang.bsl(1,32) == graph.d['t])
		
		%% from 's to 't distance is equal 10
		{'t: 10} = graph.g['s]
		10 = (graph.g['s])['t]
		
		graph = graph.add_edge('s, 'y, 5)
		
		%% distance equal 2^32
		true = (Erlang.bsl(1,32) == graph.d['s])
		true = (Erlang.bsl(1,32) == graph.d['t])
		true = (Erlang.bsl(1,32) == graph.d['y])
		
		%% from 's to 'y distance is equal 5
		{'t: 10, 'y: 5} = graph.g['s]
		5 = (graph.g['s])['y]
  end
  
  def relax_test
		graph = Graph.new
		
		%% test d after 1 relaxation, start from 's
		graph = graph.setup
		{'s: 0, 't: 10, 'x: 4294967296, 'y: 5, 'z: 4294967296} = graph.relax('s, (graph.g['s]).to_list, graph.d.merge {'s:0})
		
		%% test d after 1 relaxation, start from 't
		graph = graph.setup
		{'s: 4294967296, 't: 0, 'x: 1, 'y: 2, 'z: 4294967296} = graph.relax('t, (graph.g['t]).to_list, graph.d.merge {'t:0})
		
		%% test d after 1 relaxation, start from 'x
		graph = graph.setup
		{'s: 4294967296, 't: 4294967296, 'x: 0, 'y: 4294967296, 'z: 4} = graph.relax('x, (graph.g['x]).to_list, graph.d.merge {'x:0})
		
		%% test d after 1 relaxation, start from 'y
		graph = graph.setup
		{'s: 4294967296, 't: 3, 'x: 9, 'y: 0, 'z: 2} = graph.relax('y, (graph.g['y]).to_list, graph.d.merge {'y:0})
		
				
		%% test d after 1 relaxation, start from 'z
		graph = graph.setup
		{'s: 7, 't: 4294967296, 'x: 6, 'y: 4294967296, 'z: 0} = graph.relax('z, (graph.g['z]).to_list, graph.d.merge {'z:0})
  end

  def dijkstra_test
		graph = Graph.new.setup
		{'s: 0, 't: 8, 'x: 9, 'y: 5, 'z: 7} = graph.dijkstra('s)
		{'s: 11, 't: 0, 'x: 1, 'y: 2, 'z: 4} = graph.dijkstra('t)
		{'s: 11, 't: 19, 'x: 0, 'y: 16, 'z: 4} = graph.dijkstra('x)
		{'s: 9, 't: 3, 'x: 4, 'y: 0, 'z: 2} = graph.dijkstra('y)
		{'s: 7, 't: 15, 'x: 6, 'y: 12, 'z: 0} = graph.dijkstra('z)
  end

  def listf_test
		graph = Graph.new.setup
		dict = {'s: 0, 't: 8, 'x: 9, 'y: 5, 'z: 7}
		['s, 't, 'x, 'y, 'z] = graph.listf(dict.to_list)
  end
end
