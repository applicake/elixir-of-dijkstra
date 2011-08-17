module Graph
  attr_reader ['g, 'd, 'max_int]
  
  def __bound__
    g = {} %% graph representation, adjacency list equivalent -- dictionary of dictionaries
    d = {} %% distances
    max_int = Erlang.bsl(1,32) %% maximal distance value -- local infinity 
    
    @('g: g, 'd: d, 'max_int: max_int)
  end
  def setup
    g = {'s: {'t: 10, 'y: 5}, 't: {'x: 1, 'y: 2}, 'x: {'z: 4}, 'y: {'t: 3, 'x: 9, 'z: 2}, 'z: {'s: 7, 'x: 6}}
    d = {'s: 4294967296, 't: 4294967296, 'x: 4294967296, 'y: 4294967296, 'z: 4294967296}
    max_int = 4294967296
    @('g: g, 'd: d, 'max_int: max_int)
  end
  
  %% add_edge -- add edge to graph
  def add_edge(s,t,w)
    g = @g
    d = @d
    
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
    @('g: g, 'd: d)
  end
  
  %% dijkstra -- execute dijkstra algorithm
  def dijkstra(point)
    d = @d
    q = listf(d.to_list)
    d = d.set(point, 0)
    loop(q, d)
  end
  
%% private
%% commented for tests
    %% listf -- get list of first elements from list of pairs [{a,b}, {c,d}] -> [a,c]
    def listf([])
      []
    end
    
    def listf([a])
      {first, _second} = a
      [first]
    end
    
    def listf([h|t])
      {first, _second} = h
      [first | listf(t)]
    end
    
    %% extract_min -- extract element from list with the shortest distance
    def extract_min([], _d, key)
      key
    end
    
    def extract_min([h|t], d, key)
      if d[h] < d[key]
        extract_min(t, d, h)
      else
        extract_min(t, d, key)
      end
    end
    
    def extract_min(q, d)
      extract_min(q, d, q[0])
    end
    
    %% relax -- relaxation
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
    
    def inloop(q, d)
      g = @g
      u = extract_min(q, d)
      q = q.delete(u)
      d = relax(u, g[u].to_list, d)
      loop(q, d)
    end
    
    def loop(q, d)
      if q.length > 0
        d = inloop(q, d)
      end
      d
    end
end
