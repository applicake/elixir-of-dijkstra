c:
	rm *.beam
	elixirc graph.ex
t:
	elixir graph_test.exs
clean:
	rm -rf *.beam
