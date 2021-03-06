'use strict'

#===============================================================================
#
#	Game Utils
# 		General utilities to be used by the game drawer & manger
#
#-------------------------------------------------------------------------------

$requires = [
	'$log'
	'BOARD'
	'SHAPE'
]

utils = ( $log, BOARD, SHAPE ) ->
	utils =
		#	@getRandomInt
		# 		Get a random int between the given min + max
		#-------------------------------------------------------------------
		getRandomInt: (min, max) ->
			return Math.floor(Math.random() * (max - min + 1)) + min

		#	@coinFlip
		# 		Randomly generate a true/false
		#-------------------------------------------------------------------
		coinFlip: () ->
			isEven = utils.getRandomInt(1, 10) % 2 == 0

			return true if isEven
			return false if !isEven

		#	@hexToRgb
		# 		http://stackoverflow.com/questions/5623838/rgb-to-hex-and-hex-to-rgb
		#-------------------------------------------------------------------
		hexToRgb: (hex) ->
			# Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
			shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i
			hex = hex.replace(shorthandRegex, (m, r, g, b) ->
				return r + r + g + g + b + b
			)

			result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)

			if result
				return {
					r: parseInt(result[1], 16)
					g: parseInt(result[2], 16)
					b: parseInt(result[3], 16)
				}
			else
				return null

	return utils


utils.$inject = $requires
module.exports = utils
