ExUnit.start []

defmodule GraphTest do
  use ExUnit.Case
  test :dijkstra do
    g = [{:s,[{:t,10},{:y,5}]},{:t,[{:x,1},{:y,2}]},{:x,[{:z,4}]},{:y,[{:t,3},{:x,9},{:z,2}]},{:z,[{:s,7},{:x,6}]}]
    d = [{:s,4294967296},{:t,4294967296},{:x,4294967296},{:y,4294967296},{:z,4294967296}]
    configuration = Orddict.new [{:g,g},{:d,d}]
    [{:s, 0},{:t, 8},{:x,9},{:y, 5},{:z,7}] = Graph.dijkstra(configuration,:s)
    [{:s,11},{:t, 0},{:x,1},{:y, 2},{:z,4}] = Graph.dijkstra(configuration,:t)
    [{:s,11},{:t,19},{:x,0},{:y,16},{:z,4}] = Graph.dijkstra(configuration,:x)
    [{:s, 9},{:t, 3},{:x,4},{:y, 0},{:z,2}] = Graph.dijkstra(configuration,:y)
    [{:s, 7},{:t,15},{:x,6},{:y,12},{:z,0}] = Graph.dijkstra(configuration,:z)
  end
end
