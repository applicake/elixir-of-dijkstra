c:
	rm -rf __MAIN__
	elixirc graph.ex
t:
	elixir graph_test.exs
clean:
	rm -rf __MAIN__
