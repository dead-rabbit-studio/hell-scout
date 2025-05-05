extends Node

# Signal to interact usually with the Controller node, to notify when an action was choosed. 
signal action_required(action: String)

func _process(_delta):
	compute(0.8, 1, 0)

"""
Computes take the inputs and normalize it as a probability for an action.

 params:
	- weight: represents the available commands. if it's has more than one input it should be a list. 
   - params: represents all available information at hand. ie.: Player world position, any information that it has about an object, if he sees something that is dangereous
   - bias: represents any value to improve when weight is zero
"""
# TODO: Connect the param to receive some value like the player position and if the prize is near to him
func compute(weight: float, params: float, bias: float) -> void:
	var prediction = weight * params + bias
	print("softmax prediction: " + str(prediction))
	var softmax_denominator = softmax([prediction])

	var action = choose_action(softmax_denominator)
	action_required.emit(action)

func softmax(predictions: Array, temperature: float = 1.0) -> Array:
	var max_value = predictions[0]
	for i in range(1, predictions.size()):
		if predictions[i] > max_value:
			max_value = predictions[i]
	
	var exp_values = []
	var sum_exp = 0.0
	for prediction in predictions:
		var exp_prediction = exp(prediction - max_value)
		exp_values.append(exp_prediction)
		sum_exp += exp_prediction

	var softmax_values = []
	for exp_value in exp_values:
		softmax_values.append(exp_value / sum_exp)

	print("softmax_values: " + str(softmax_values))
		
	return softmax_values

	
func choose_action(probabilities: Array) -> String:
	var rand_val = randf()
	var cumulative = 0.0

	var selected_action = -1

	for i in range(probabilities.size()):
		cumulative += probabilities[i]
		if rand_val <= cumulative:
			selected_action = i
			break

	selected_action = probabilities.size() - 1

	if selected_action == -1:
		selected_action = probabilities.size() - 1

	var choosed_action = R.player_actions.keys()[selected_action]
	print("softmax choosed action: " + choosed_action)

	return choosed_action
