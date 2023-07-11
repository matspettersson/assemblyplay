# python3 >= 3.6 for typehint support
# This example avoids the complexity of ordering
# through type conversions & string manipulation


def isArmstrong(val: int) -> bool:
	"""val will be tested to see if its an Armstrong number.
	Arguments:
		val {int} -- positive integer only.
	Returns:
		bool -- true is /false isn't
	"""

	# break the int into its respective digits
	parts = [int(_) for _ in str(val)]

	# begin test.
	counter = 0
	for _ in parts:
		counter += _**3
	return (counter == val)


# Check Armstrong number
print(isArmstrong(153))

print(isArmstrong(1253))
