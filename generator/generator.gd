extends Node

var parent

var rnd = RandomNumberGenerator.new()
var santa_drawings_done = false

var males = ["Timmy","Moe","Oliver","Ethan","Luca","Billy","Frank","Noah","Enzo","Felix","Diego","Tomasz","Alberto","Mohamed","Magnus","Mario","Sergei"]
var females = ["Linda","Sarah","Paula","Meredith","Amelia","Chloe","Marie","Antonia","Alice","Heidi","Mitsuki","Martina","Anastasia"]
var surnames = ["Smith","Johansen","Williams","Jones","Patel","Müller","Nkosi","Fischer","Dos Santos","López","Garcia","Kimura"]
var country = ["Italy","France","USA","Germany","Canada","Mexico"]

var names = [males,females]

var Name = names.pick_random().pick_random()
var surname = surnames.pick_random()

#Store as sentence:value
var bad_habits = {
	"was responsible for the dinosaurs to go extinct ":-150,
	"wished for rain to ruin a picnic ":-10,
	"bit his sister on average 3 times a day":-20,
	"robbed a bank with a water gun":-80,
	"helped overthrow the government to install a dictatorship":-130,
	"told other kids Santa isn't real":-40,
	"started arson on Nikki's tree house":-70,
	"left Mr Clarke for dead after a hit 'n' run with tricycle":-60,
	"sold nuclear warheads to China":-110,
	"gave Mrs Huffman's cat to the animal shelter":-30,
	"impersonated neighbour to falsely file for divorce":-30,
	"reported Mr Grouche to the police as a Nazi":-40,
	"cooked meth with his chemistry teacher!":-80,
	"dealt drugs to the Mexican cartel":-90,
	"prank called the White House":-20,
	"invested in OnlyFans":-30,
	"signed up grandma for OnlyFans":-50,
	"got an F in Math":-20,
	"burned down a church":-100,
	"killed their family dog":-60,
	"reported Mom to have Munchausen by proxy":-70,
	"sent aunt Jane to the psych ward":-50,
	"was late to school 56 times":-30,
	"yelled \"BOMB\" at an airport":-70,
	"participated in bull fighting":-80,
	"ran away from home 4 times":-30,
	"pronounces GIF as JIF all the time":-20,
	"electrocuted uncle Steve":-90,
	"became the boss of the Mafia in Naples":-130,
	"kidnapped Aldo Moro in Italy in the 80's":-70,
	"rickrolled Santa's HQ":-50
}
var good_habits = {
	"gave his full allowance to a local animal shelter":30,
	"opened a charity fund for kids with cancer":60,
	"solved poverty in 3 countries":140,
	"learned Spanish to be able to speak with grandma":40,
	"helped someone understand Taylor Swift lyrics":10,
	"picked up a stranger's money on the ground and gave it back":20,
	"helped overthrow the government's dictatorship":120,
	"went back in time and assassinated Adolf Hitler":130,
	"planted 700 trees":70,
	"got an A+ in social sciences":20,
	"sold cookies at a bake sale for charity":50,
	"gave his little sister lots of attention":20,
	"helped Mom with the dishes":10,
	"attended long funeral without screaming a single time":10,
	"won a Nobel Peace Prize":100,
	"won an Oscar for Titanic III":80,
	"cured 2 forms of cancer":150,
	"invented the internet":100,
	"got a phd in astrophysics":90,
	"helped a kid in class to get a good grade":20,
	"did NOT vote the anvil as the special object":30
}

var neutral_habits = {
	"watched The God Father 7 times":0,
	"wears pyjamas inside out all of the time":0,
	"doesn't know the difference between a microwave and a oven":0,
	"loves Disney movies":0,
	"playes ice hockey":0,
	"believes in aliens":0,
	"doesn't know the difference between tomato sauce and ketchup":0,
	"eats pineapple pizza":0,
	"doesn't like mushroom":0,
	"sleeps with a night light on":0,
	"joined the chess club":0
}


var drawings = {
	"was responsible for the dinosaurs to go extinct ":"res://assets/graphics/actions/was responsible for the dinosaurs to go extinct.jpg",
	"wished for rain to ruin a picnic ":"res://assets/graphics/actions/wished for rain to ruin a picnic.jpg",
	"bit his sister on average 3 times a day":"res://assets/graphics/actions/bit his sister on average 3 times a day.jpg",
	"robbed a bank with a water gun":"res://assets/graphics/actions/test.png",
	"helped overthrow the government to install a dictatorship":"res://assets/graphics/actions/helped overthrow the government to install a dictatorship.jpg",
	"told other kids Santa isn't real":"res://assets/graphics/actions/told other kids Santa isnt real.jpg",
	"started arson on Nikki's tree house":"res://assets/graphics/actions/started arson in Nikkis tree house.jpg",
	"left Mr Clarke for dead after a hit 'n' run with tricycle":"res://assets/graphics/actions/left Mr Clarke for dead after a hitnrun with tricycle.jpg",
	"sold nuclear warheads to China":"res://assets/graphics/actions/sold nuclear warheads to China.jpg",
	"gave Mrs Huffman's cat to the animal shelter":"res://assets/graphics/actions/gave away Mrs Huffman's cat to the animal shelter.jpg",
	"impersonated neighbour to falsely file for divorce":"res://assets/graphics/actions/impersonated neighbour to falsely file for divorce.jpg",
	"reported Mr Grouche to the police as a Nazi":"res://assets/graphics/actions/reported Mr Grouche to the police as a Nazi.jpg",
	"cooked meth with his chemistry teacher!":"res://assets/graphics/actions/cooked meth with their chemistry teacher.jpg",
	"dealt drugs to the Mexican cartel":"res://assets/graphics/actions/dealt drugs to the Mexican cartel.jpg",
	"prank called the White House":"res://assets/graphics/actions/prank called the White House.jpg",
	"invested in OnlyFans":"res://assets/graphics/actions/invested in OnlyFans.jpg",
	"signed up grandma for OnlyFans":"res://assets/graphics/actions/signed up grandma for OnlyFans.jpg",
	"got an F in Math":"res://assets/graphics/actions/got an F in Math.jpg",
	"burned down a church":"res://assets/graphics/actions/burned down a church.jpg",
	"killed their family dog":"res://assets/graphics/actions/killed their family dog.jpg",
	"reported Mom to have Munchausen by proxy":"res://assets/graphics/actions/reported Mom to have Munchausen by proxy.jpg",
	"sent aunt Jane to the psych ward":"res://assets/graphics/actions/sent aunt Jane to the psych ward.jpg",
	"was late to school 56 times":"res://assets/graphics/actions/was late to school 56 times.jpg",
	"yelled \"BOMB\" at an airport":"res://assets/graphics/actions/yelled BOMB at an airport.jpg",
	"participated in bull fighting":"res://assets/graphics/actions/participated in bull fighting.jpg",
	"ran away from home 4 times":"res://assets/graphics/actions/ran away from home 4 times.jpg",
	"pronounces GIF as JIF all the time":"res://assets/graphics/actions/pronounced GIF as JIF all the time.jpg",
	"electrocuted uncle Steve":"res://assets/graphics/actions/electrocuted uncle Steve.jpg",
	"became the boss of the Mafia in Naples":"res://assets/graphics/actions/became the boss of the Mafia in Naples.jpg",
	"kidnapped Aldo Moro in Italy in the 80's":"res://assets/graphics/actions/kidnapped Aldo Moro in Italy in the 80s.jpg",
	"rickrolled Santa's HQ":"res://assets/graphics/actions/rickrolled Santas headquarrters.jpg"
	}

var anvil_things = ["destroyed a game jam",
	"was voted 'Worst Object Ever' this year",
	"ruined everyone's plans",
	"was just awful for people's imaginations",
	"brought down Christmas",
	"removed happiness",
	"created several teams to squabble",
	"temp1",
	"temp2",
	"temp3",
	"temp4",
	"temp5",
	"temp6",
	"temp7",
	"temp8",
	"temp9",
	"temp10"]
	
var selected_anvil_things = []

var selected_good_habits = {} #All selected good_habits
var selected_bad_habits = {} #All selected bad_habits
var selected_neutral_habits = {}

@onready var sfx = $/root/Level/sounds

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
	var decider = ["good","bad","neutral"] # For each event thier is a 50% chance
	for i in range(0,EVENT_COUNT):
		var randomchoice = decider.pick_random()
		while (randomchoice == "neutral" and len(selected_neutral_habits) >= 2):
			randomchoice = decider.pick_random()
		match randomchoice: 
			"good":
				mergedic(selected_good_habits,good_habit_selector()) # adding good and bad event one by one
			"bad":
				mergedic(selected_bad_habits,bad_habit_selector())
			"neutral":
				mergedic(selected_neutral_habits,neutral_habit_selector())
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

func neutral_habit_selector():
	var length_of_habits = len(neutral_habits) - 1 
	var random = randi_range(0,length_of_habits)
	var keylist = neutral_habits.keys()
	var key = keylist[random]
	while selected_neutral_habits.has(key):
		random = randi_range(0,len(neutral_habits)-1)
		keylist = neutral_habits.keys()
		key = keylist[random]
	var dic = {key:neutral_habits[key]}
	return dic

func child(): 
	$Paper/TempBg/Profile/Story.text = "It's been reported that little "+ Name + " "
	var good = selected_good_habits.keys()
	var bad = selected_bad_habits.keys()
	var neutral = selected_neutral_habits.keys()
	var all = []
	for x in good:
		all.append(x)
	for x in bad:
		all.append(x)
	for x in neutral:
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
	selected_neutral_habits = {}

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
	$Paper/TempBg/Profile/Data.text = "Age: 7 Days"+"\nHeight: 35 cm" + "\nFrom: GameJam"
	$Paper/TempBg/Profile/Name.text = "Anvil"

func _on_close_pressed():
	$Animation.play("close")

func _on_story_meta_clicked(meta):
	print("clicked")
	if drawings.keys().has(meta):
		$Drawing.texture = ResourceLoader.load(drawings[meta])
		sfx.drawing_show()
		if santa_drawings_done == false:
			sfx.santa_drawing()
			santa_drawings_done = true

func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		self.visible = false
		santa_drawings_done = false

func _on_decide_pressed():
	$Animation.play("close")
	parent.clicked = true
	sfx.paper("hide")

func _on_detection_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Drawing,"scale",Vector2(1.5,1.5),0.2).set_ease(Tween.EASE_IN)

func _on_detection_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Drawing,"scale",Vector2(0.8,0.8),0.2).set_ease(Tween.EASE_OUT)
