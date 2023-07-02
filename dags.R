library(dagitty)
library(tidySEM)

# p1 <- prepare_graph(dagitty::dagitty("dag{A -> B}"), layout = get_layout("A", "B", "C", rows = 1))
#
# p2 <- prepare_graph(dagitty::dagitty("dag{
# A <- B
# }"), layout = get_layout("A", "B", "C", rows = 1))


# model_direct (revised)
mdir <- prepare_graph(dagitty::dagitty("dag{
A -> B
}"), layout = get_layout("A", "B", "C", rows = 1))

# model_indirect (revised)
mindir <- prepare_graph(dagitty::dagitty("dag{
A -> B;
B -> C
}"), layout = get_layout("", "B", "",
                         "A", "", "C", rows = 2), angle = 179)

# model_common_cause (revised)
mcommon <- prepare_graph(dagitty::dagitty("dag{
B -> A;
B -> C
}"), layout = get_layout("", "B", "",
                         "A", "", "C", rows = 2), angle = 179)

# model_colliders (revised)
mcollider <- prepare_graph(dagitty::dagitty("dag{
A -> B;
C -> B
}"), layout = get_layout("A", "", "C",
                         "", "B", "", rows = 2), angle = 179)

# model_reverse_causation (revised)
mrev <- prepare_graph(dagitty::dagitty("dag{
B -> A
}"))

# model_feedback_loop (revised)
mloop <- prepare_graph(dagitty::dagitty("dag{
A -> B;
B -> A
}"), angle = 1, layout = get_layout("A", "B", rows = 1))
mloop$edges$curvature <- 60
mloop$edges$connect_from <- c("bottom", "top")[2:1]
mloop$edges$connect_to <- c("bottom", "top")[2:1]

p <- merge.sem_graph(mdir, mrev, mloop, mindir, mcommon, mcollider, ncol = 3, nrow = 2, distance_x = 0, distance_y = 0)
plot(p)
