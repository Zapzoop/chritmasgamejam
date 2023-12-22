extends Node

var parent

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

var drawings = {
	"robbed a bank with a water gun":"res://assets/grafics/actions/CancerFound.png",
	"kidnapped Aldo Moro in the 80s in Italy":"res://assets/grafics/actions/CancerFound.png",
	"helped overtrow a government to install a dicatorship":"res://assets/grafics/actions/CancerFound.png",
	"said YOLO in 482 conversations this year":"res://assets/grafics/actions/CancerFound.png",
	"Invests in Lockheed martin when word tension goes up":"res://assets/grafics/actions/CancerFound.png",
	"told other kids Santa isn't real":"res://assets/grafics/actions/CancerFound.png",
	"accused of arson on Nikki's tree house":"res://assets/grafics/actions/CancerFound.png",
	"hit n run on neighbor with your three wheeler":"res://assets/grafics/actions/CancerFound.png",
	"sold nuclear warheads to China":-2,
	"gave Mrs Huffman's cat to the animal shelter, saying it was a stray":"res://assets/grafics/actions/CancerFound.png",
	"impersonated neighbor to file for divorce with his wife":"res://assets/grafics/actions/CancerFound.png",
	"reported Mr Grouche to the police as a Nazi":"res://assets/grafics/actions/CancerFound.png",
	"crooked meth with his chemistry teacher!":"res://assets/grafics/actions/CancerFound.png",
	"dealt drugs to the Mexican cartel":"res://assets/grafics/actions/CancerFound.png",
	"Gave all his allowance to the local animal scelter":"res://assets/grafics/actions/test.png",
	"he opened a charity found for kids with cancer" :"res://assets/grafics/actions/test.png",
	"temp1":"res://assets/grafics/actions/test.png",
	"temp2":"res://assets/grafics/actions/test.png",
	"temp3":"res://assets/grafics/actions/test.png"
	}

var anvil_things = ["destroyed a game jam",
	"was voted 'Worst Object Ever' this year",
	"ruined everyone's plans",
	"was just awful for people's imaginations",
	"brought down Christmas",
	"removed happiness",
	"created several teams to squabble"]
var selected_anvil_things = []

var selected_good_habits = {} #All selected good_habits
var selected_bad_habits = {} #All selected bad_habits

func _ready():
	if get_parent().is_in_group("anvil"):
		data_anvil()
	else:
		$Paper/TempBg/Profile/Data.text = "Age: " + str(int(rnd.randi_range(5,11))) + "\nHeight: " + str(int(rnd.randi_range(100,160))) + " cm \nFrom: " + country.pick_random()
		$Paper/TempBg/Profile/Name.text = Name + " " + surname

func mergedic(dic1,dic2): #Merging two dictionaries Adding dic2 to dic1
	var key_list = dic2.keys()
	for i in range(len(dic2)):
		var key = key_list[i]
		dic1[key] = dic2[key]

func create_child():
	if parent.is_in_group("anvil"):
		create_anvil()
		return
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
	var length_of_habits = len(good_habits) - 1 
	var random = randi_range(0,length_of_habits)
	var keylist = good_habits.keys()
	var key = keylist[random]
	while selected_good_habits.has(key): #Will loop if the said event is already thier
		random = randi_range(0,len(good_habits)-1)
		keylist = good_habits.keys()
		key = keylist[random]
	var dic = {key:good_habits[key]}
	return dic
	
func bad_habit_selector():
	var length_of_habits = len(bad_habits) - 1 
	var random = randi_range(0,length_of_habits)
	var keylist = bad_habits.keys()
	var key = keylist[random]
	while selected_bad_habits.has(key):
		random = randi_range(0,len(bad_habits)-1)
		keylist = bad_habits.keys()
		key = keylist[random]
	var dic = {key:bad_habits[key]}
	return dic

func child(): 
	$Paper/TempBg/Profile/Story.text = "It's been reported that little "+ Name + " "
	var good = selected_good_habits.keys()
	var bad = selected_bad_habits.keys()
	var all = []
	for x in good:
		all.append(x)
	for x in bad:
		all.append(x)
	all.shuffle()
	$Paper/TempBg/Profile/Story.text +="has "+ "[color=red][url]"+ all[0]+ "[/url][/color]" + " and " + "[color=red][url]"+ all[1]+ "[/url][/color]" + ". Furthermore, the list goes on stating that this kid "
	for x in range(2,5):
		$Paper/TempBg/Profile/Story.text += ",[color=red] [url]"  + all[x] + "[/url][/color]"
	report_card()

func report_card():
	var positive_score = 0
	var negative_score = 0
	var keylist_good = selected_good_habits.keys()
	var keylist_bad = selected_bad_habits.keys()
	for i in range(len(selected_good_habits)): 
		positive_score += selected_good_habits[keylist_good[i]]
	for i in range(len(selected_bad_habits)):
		negative_score += selected_bad_habits[keylist_bad[i]]
	var total = positive_score + negative_score #Calculates the score
	parent.child_score = total
	print("My score " + str(total))
	selected_bad_habits = {} #Emptying occupied habits
	selected_good_habits = {}

func create_anvil():
	for x in range(5):
		var anv = anvil_things.pick_random()
		while selected_anvil_things.has(anv):
			anv = anvil_things.pick_random()
		selected_anvil_things.append(anv)
	$Paper/TempBg/Profile/Story.text = "It's been reported that Bully Anvil "
	$Paper/TempBg/Profile/Story.text +="has "+ "[color=red][url]"+ selected_anvil_things[0]+ "[/url][/color]" + " and " + "[color=red][url]"+ selected_anvil_things[1]+ "[/url][/color]" + ". Furthermore, the list goes on stating that this kid "
	for x in range(2,5):
		$Paper/TempBg/Profile/Story.text += ",[color=red] [url]"  + selected_anvil_things[x] + "[/url][/color]"
	selected_anvil_things = []

func data_anvil():
	$Paper/TempBg/Profile/Data.text = "Age: 7 Days"+"\nHeight: 6 m" + "\nFrom: GameJam"
	$Paper/TempBg/Profile/Name.text = "Anvil"

func _on_close_pressed():
	$Animation.play("close")

func _on_story_meta_clicked(meta):
	$Drawing.texture = ResourceLoader.load(drawings[meta])

func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		self.visible = false
		parent.can_drag = true

func _on_decide_pressed():
	$Animation.play("close")
	parent.verdictdone = true
