ExUnit.start []

defmodule GraphTest do
  use ExUnit.Case
  test :dijkstra do
    g = [{:s,[{:t,10},{:y,5}]},{:t,[{:x,1},{:y,2}]},{:x,[{:z,4}]},{:y,[{:t,3},{:x,9},{:z,2}]},{:z,[{:s,7},{:x,6}]}]
    d = [{:s,4294967296},{:t,4294967296},{:x,4294967296},{:y,4294967296},{:z,4294967296}]
    configuration = :orddict.from_list([{:g,g},{:d,d}])
    [x: 9, z: 7, t: 8, y: 5, s: 0] = Graph.dijkstra(configuration,:s)
    [s: 11, z: 4, y: 2, x: 1, t: 0] = Graph.dijkstra(configuration,:t)
    [t: 19, y: 16, s: 11, z: 4, x: 0] = Graph.dijkstra(configuration,:x)
    [x: 4, s: 9, z: 2, t: 3, y: 0] = Graph.dijkstra(configuration,:y)
    [t: 15, y: 12, x: 6, s: 7, z: 0] = Graph.dijkstra(configuration,:z)
  end
end
