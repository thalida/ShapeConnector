'use strict'

$requires = [
	'$log'
	'$rootScope'
	'$scope'
	'$state'
	'LEVELS'
	require '../../services/gameSettings'
]

class SettingsController
	constructor: ($log, $rootScope, $scope, $state, LEVELS, gameSettings) ->
		@isProd = $rootScope.isProdSite
		@levels = angular.copy( LEVELS )
		@levels.DEFAULT = null

		@selectedLevel = gameSettings.getDifficulty()

		if $rootScope.isProdSite
			@levels.DEV = null

		@setDifficulity = ( level ) ->
			if @levels[ level ]?
				gameSettings.setDifficulty( level )
				@selectedLevel = level


SettingsController.$inject = $requires
module.exports = SettingsController