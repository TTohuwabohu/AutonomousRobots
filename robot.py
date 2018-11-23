import clingo

class Robot(object):

	def __init__(self, id, start, encoding, instance):
		self.id = id
		self.start = [-1,-1]
		self.start[0] = start[0]
		self.start[1] = start[1]
		self.pos = [-1,-1]
		self.pos[0] = start[0]
		self.pos[1] = start[1]

		self.next_pos = [-1,-1]

		self.state = []
		self.t=-1

		self.order =[-1,-1,-1]

		self.pickupdone = False
		self.deliverdone = False

		#self.prg = clingo.Control()
		#self.prg.load(encoding)
		#self.prg.load(instance)
		#self.prg.ground([("base", [])])
		
		
	def set_order(self, id, p, s, prg):
		#print(type(order))
		self.order[0] = id
		self.order[1] = p
		self.order[2] = s
		#print ( "order("+str(p)+", "+str(s)+", "+str(self.id)+", "+str(id)+").")
		prg.add("base", [], "order("+str(p)+", "+str(s)+", "+str(self.id)+", "+str(id)+").")
	

	def update_state(self, state):
		if self.state == []:
			self.state = state
		for i in range(len(state)):
			for j in range(len(state[0])):
				if ((i == self.pos[0]-1 and abs(j-(self.pos[1]-1)) == 1) or
					(abs(i-(self.pos[0]-1)) == 1 and j == self.pos[1]-1)):
					# roboter kann nur auf felder schauen auf die er sich bewegen koennte
					self.state[i][j] = state[i][j]
				else:
					# alle anderen positionen als frei angenommen
					self.state[i][j] = 1
