import sys
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from matplotlib_venn import venn2

v=venn2(subsets=(5,5,3),set_labels=("",""))
v.get_patch_by_id("10").set_color("seagreen")
v.get_patch_by_id("01").set_color("yellowgreen")
v.get_patch_by_id("11").set_color("olive")
v.get_patch_by_id("10").set_alpha(1.0)
v.get_patch_by_id("01").set_alpha(1.0)
v.get_patch_by_id("11").set_alpha(1.0)
v.get_label_by_id("10").set_text("Researcher")
v.get_label_by_id("11").set_text("Research\n Software\n Developer")
v.get_label_by_id("01").set_text("Software\n Developer")
v.get_label_by_id("10").set_color("white")
v.get_label_by_id("01").set_color("white")
v.get_label_by_id("11").set_color("white")
plt.savefig(sys.argv[1],facecolor="black")
