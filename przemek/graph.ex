object Graph
	def initialize()
		g = {:}
		d = {:}
		nodes = Set.new()
		max_int = Erlang.bsl(1,32)
		
		@('g: g, 'd: d, 'nodes: nodes, 'max_int: max_int)
	end
	def setup()
		g = {'s: {'t: 10, 'y: 5}, 't: {'x: 1, 'y: 2}, 'x: {'z: 4}, 'y: {'t: 3, 'x: 9, 'z: 2}, 'z: {'s: 7, 'x: 6}}
		d = {'s: 4294967296, 't: 4294967296, 'x: 4294967296, 'y: 4294967296, 'z: 4294967296}
		nodes = Set.from_list(['s, 't, 'x, 'y, 'z])
		max_int = 4294967296
		@('g: g, 'nodes: nodes, 'max_int: max_int, 'd: d)
	end
	
	def add_edge(s,t,w)
		g = @g
		d = @d
		nodes = @nodes
		
		if g[s] == nil
			g = g.merge {s:{t:w}}
		else
			g = g.update s, _.merge {t:w}
		end
		if d[s] == nil
			d = d.merge {s: @max_int}
		end
		if d[t] == nil
			d = d.merge {t: @max_int}
		end
		if nodes.include?(s) == false
			nodes = nodes.add(s)
		end
		if nodes.include?(t) == false
			nodes = nodes.add(t)
		end
		@('g: g, 'd: d, 'nodes: nodes)
	end
	
	def dijkstra(point)
		d = @d
		s = Set.new()
		q = Erlang.gb_trees.from_orddict(@d.to_list)
		d = d.set(point, 0)
		loop(s, q, d)
	end
	
	private
	
		def extract_min(q, d)
			it = Erlang.gb_trees.iterator(q)
			{key, _value, it} = Erlang.gb_trees.next(it)
			get_min(key, it, d)
		end
		
		def get_min(min_key, [], d)
			{min_key, d[min_key]}
		end
		
		def get_min(min_key, it, d)
			{key, _value, it} = Erlang.gb_trees.next(it)
			if d[key] < d[min_key]
				min_key = key
			end
			get_min(min_key, it, d)
		end
		
		def relax(_u, [], d)
			d
		end
		
		def relax(u, list, d)
			[{v, w} | t] = list
			if d[v] > d[u] + w
				d = d.set(v, d[u] + w)
			end
			relax(u, t, d)
		end
		
		def inloop(s, q, d)
			g = @g
			{u, _min} = extract_min(q, d)
			q = Erlang.gb_trees.delete(u, q)
			IO.puts q.to_list
			s = s.add(u)
			d = relax(u, g[u].to_list, d)
			loop(s, q, d)
		end
		
		def loop(s, q, d)
			if Erlang.gb_trees.is_empty(q) == false
				d = inloop(s, q, d)
			end
			d
		end
end
