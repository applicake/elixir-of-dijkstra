defmodule Graph do
  def dijkstra(configuration, point) do
    g = Dict.get(configuration, :g)
    d = Dict.get(configuration, :d)

    q = Keyword.keys(d)
    d = Keyword.merge(d, [{point, 0}])
    loopy(g, q, d)
  end

  def extract_min([], _d, key) do
    key
  end

  def extract_min([h|t], d, key) do
    if d[h] < d[key] do
      extract_min(t, d, h)
    else:
      extract_min(t, d, key)
    end
  end

  def extract_min(q, d) do
    [f|_] = q
    extract_min(q, d, f)
  end

  def relax(_u, [], d) do
    d
  end

  def relax(u, list, d) do
    [{v, w} | t] = list
    if d[v] > d[u] + w do
      d = Keyword.merge(d, [{v, d[u] + w}])
    end
    relax(u, t, d)
  end

  def loopy(g, q, d) do
    if length(q) > 0 do
      d = inloop(g, q, d)
    end
    d
  end

  def inloop(g, q, d) do
    u = extract_min(q, d)
    q = List.delete(q, u)
    d = relax(u, g[u], d)
    d = loopy(g, q, d)
  end
end

