do: run

compile:
	@echo "==================================================================================="
	g++ gkls.c rnd_gen.c Asimpl_main.cpp -o asimpl.out
	# g++ -std=c++11 gkls.c rnd_gen.c Asimpl_main.cpp -o asimpl.out

run: compile
	clear
	./asimpl.out --func_cls=1 --func_id=1 --stop_crit=ei
	

test:
	g++ test.cpp -o test.out
	clear
	./test.out

run_elbme: compile_elbme
	clear
	./elbme.out


compile_elbme:
	@echo "==================================================================================="
	g++ gkls.c elbme_main.cpp -o elbme.out

cat:
	cat *.sh.po*
	cat *.sh.o*

queue:
	qstat -f
	# qdel

num:
	ls results/Disimpl-v/ | wc -l

mem_check:  compile
	valgrind --tool=memcheck --leak-check=full --track-origins=yes -v ./asimpl.out --func_cls=1 --func_id=1

profiler:  compile
	valgrind --tool=callgrind ./asimpl.out --func_cls=1 --func_id=1
	# git clone https://github.com/jrfonseca/gprof2dot bin/gprof2dot
	./bin/gprof2dot/gprof2dot.py -f callgrind callgrind.out.* | dot -Tsvg -o profile.svg
