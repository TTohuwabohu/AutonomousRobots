class Printer(object):
	def add_inits(self, inits):
		type(inits)
		for atom in inits:
			print(atom)

	def add(self, rid, name, args, t):
		txt = "occurs(object(robot,"+str(rid)+"),action("+name+",("
		if name == "move":
			txt += str(args[0])+","+str(args[1])
		elif name == "deliver":
			txt += str(args[0])+","+str(args[1])
		txt += ")),"+str(t)+")"

		print(txt)

	def run(self, steps):
		return