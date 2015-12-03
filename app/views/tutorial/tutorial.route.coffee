'use strict'

route = ($stateProvider) ->
	$stateProvider.state('tutorial',
		url: '/tutorial'
		templateUrl: 'views/tutorial/tutorial.html'
		controller: 'TutorialController'
		controllerAs: 'tutorial'
	)

route.$inject = ['$stateProvider']

module.exports = route