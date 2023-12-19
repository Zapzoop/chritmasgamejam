extends Node
#TO RUN THE SCRIPT ADD IT TO ANY NODE AND THEN INSTANCE THAT SCENE

var parent
var id
var newparent


var rnd = RandomNumberGenerator.new()

var males = ["Timmy","Moe","Oliver","Ethan","Luca","Billy","Frank","Noah","Enzo","Felix","Diego","Tomasz","Alberto","Mohamed","Magnus","Mario","Sergei"]
var females = ["Linda","Sarah","Paula","Meredith","Amelia","Chloe","Marie","Antonia","Alice","Heidi","Mitsuki","Martina","Anastasia"]
var surnames = ["Smith","Johansen","Williams","Jones","Patel","Müller","Nkosi","Fischer","Dos Santos","López","Garcia","Kimura"]
var country = ["Italy","France","USA","Germany","Canada","Mexico"]

var names = [males,females]

var Name = names.pick_random().pick_random()
var surname = surnames.pick_random()

#Store as sentence:value
var bad_habits = {
	"robbed a bank with a water gun":-30,
	"kidnapped Aldo Moro in the 80s in Italy":-70,
	"helped overtrow a government to install a dicatorship":-10,
	"said YOLO in 482 conversations this year":-40,
	"Invests in Lockheed martin when word tension goes up":-20,
	"told other kids Santa isn't real":-100,
	"accused of arson on Nikki's tree house":-30,
	"hit n run on neighbor with your three wheeler":-90,
	"sold nuclear warheads to China":-2,
	"gave Mrs Huffman's cat to the animal shelter, saying it was a stray":-70,
	"impersonated neighbor to file for divorce with his wife":-50,
	"reported Mr Grouche to the police as a Nazi":-20,
	"crooked meth with his chemistry teacher!":-30,
	"dealt drugs to the Mexican cartel":-55
}
var good_habits = {
	"Gave all his allowance to the local animal scelter":55,
	"he opened a charity found for kids with cancer" :5,
	"temp1":8,
	"temp2":90,
	"temp3":99
}
var selected_good_habits = {} #All selected good_habits
var selected_bad_habits = {} #All selected bad_habits
# Called when the node enters the scene tree for the first time.
func _ready():
	print("child 1")
	create_child()
	$"paper/just untile we get the texture/Control/data".text = "age: " + str(int(rnd.randi_range(5,11))) + "\nheight: " + str(int(rnd.randi_range(100,160))) + "cm \nfrom: " + country.pick_random()
	$"paper/just untile we get the texture/Control/name".text = Name + " " + surname

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mergedic(dic1,dic2): #Merging two dictionaries Adding dic2 to dic1
	var key_list = dic2.keys()
	for i in range(len(dic2)):
		var key = key_list[i]
		dic1[key] = dic2[key]
		

func create_child():
	const EVENT_COUNT = 5 # Number of events linked to child
	var decider = ["good","bad"] # for each event thier is a 50% chance
	for i in range(0,EVENT_COUNT):
		var random = randi_range(0,1)
		var final_decider = decider[random]
		match final_decider: 
			"good":
				mergedic(selected_good_habits,good_habit_selector()) # adding good and bad event one by one
			"bad":
				mergedic(selected_bad_habits,bad_habit_selector())
				
	child()

func good_habit_selector():
	var random = randi_range(0,len(good_habits)-1)
	var keylist = good_habits.keys()
	var key = keylist[random]
	while selected_good_habits.has(key): # will loop if the said event is already thier
		random = randi_range(0,len(good_habits)-1)
		keylist = good_habits.keys()
		key = keylist[random]
	var dic = {key:good_habits[key]}
	return dic
	
func bad_habit_selector():
	var random = randi_range(0,len(bad_habits)-1)
	var keylist = bad_habits.keys()
	var key = keylist[random]
	while selected_bad_habits.has(key):
		random = randi_range(0,len(bad_habits)-1)
		keylist = bad_habits.keys()
		key = keylist[random]
	var dic = {key:bad_habits[key]}
	return dic

 #To be added in child script

func report_card():
	var positive_score = 0
	var negative_score = 0
	var keylist_good = selected_good_habits.keys()
	var keylist_bad = selected_bad_habits.keys()
	
	for i in range(len(selected_good_habits)): # Calculates the score
		positive_score += selected_good_habits[keylist_good[i]]
	for i in range(len(selected_bad_habits)):
		negative_score += selected_bad_habits[keylist_bad[i]]
		
	var total = positive_score + negative_score
	Global.child_score = total
	print("My score = " + str(total))
	
	selected_bad_habits = {} #emptying occupied habits
	selected_good_habits = {}

func child(): 
	$"paper/just untile we get the texture/Control/story".text = "it's been reported that little "+ Name + " "
	var rand = RandomNumberGenerator
	var good = selected_good_habits.keys()
	var bad = selected_bad_habits.keys()
	var all = []
	for x in good:
		
		all.append(x)
	for x in bad:
		all.append(x)
	
	$"paper/just untile we get the texture/Control/story".text +="has "+ "[color=red]"+ all[0]+ "[/color]" + " and " + "[color=red]"+ all[1]+ "[/color]" + ". Furthermore, the list goes on stating that this kid "
	for x in range(2,5):
		$"paper/just untile we get the texture/Control/story".text += "[color=red], "  + all[x] + "[/color]"
	
	report_card()

func _on_naughty_pressed():
	parent.verdictdone = true
	self.visible = false
	parent.can_drag = true

func _on_nice_pressed():
	parent.verdictdone = true
	self.visible = false
	parent.can_drag = true

func _on_close_pressed():
	self.visible = false
		
func makerestinvisible():
	for i in range(newparent.get_child_count()):
		var child = newparent.get_child(i)
		if self.visible == true and child != self:
			child.visible = false
