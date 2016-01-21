'use strict'

#===============================================================================
#
#	ShapeConnector Slideshow Directive
#
#-------------------------------------------------------------------------------

angular.module('app').directive 'slideshow', [
	'$log'
	'$timeout'
	'BOARD'
	require '../../services/utils'
	( $log, $timeout, BOARD, utils ) ->
		templateUrl: 'components/slideshow/slideshow.html'
		transclude: true
		restrict: 'E'
		scope: {}
		bindToController:
			eventHandler: '&?'
		controllerAs: 'slideshow'
		controller: ['$scope', '$element', '$transclude', ($scope, $el, $transclude) ->
			@slides = []

			@addSlide = ( slide ) =>
				@slides.push( slide )
				return @slides

			@showSlide = ( slide, direction ) =>
				slide.show( direction )
				return

			@hideSlide = ( slide, direction ) =>
				slide.hide( direction )
				return

			@goTo = ( directionName, trigger ) ->
				if @autoSlideTimeout?
					$timeout.cancel( @autoSlideTimeout )

				direction = if directionName is 'next' then 1 else -1

				@directionClass = if directionName is 'next' then 'left' else 'right'
				@priorSlide = @currSlide
				@currSlideIdx += direction

				if directionName is 'next' and @currSlideIdx > @slides.length - 1
					@currSlideIdx = 0
				else if directionName is 'prev' and @currSlideIdx < 0
					@currSlideIdx = @slides.length - 1

				@currSlide = @slides[@currSlideIdx]

				if @priorSlide?
					@hideSlide( @priorSlide, @directionClass )

				@showSlide( @currSlide, @directionClass )

				# @setTimeout()

				return

			@setTimeout = () ->
				@autoSlideTimeout = $timeout(@nextSlide, 10000)
				return @autoSlideTimeout

			return this
		]
		link: ($scope, el, attrs) ->
			$scope.slideshow.currSlideIdx = -1
			$scope.slideshow.goTo('next', 'self')
			return
]

#===============================================================================
#
#	Slideshow Slide Directive
#
#-------------------------------------------------------------------------------

angular.module('app').directive 'slide', [
	'$log'
	'$parse'
	'$timeout'
	( $log, $parse, $timeout ) ->
		require: '^slideshow'
		restrict: 'E'
		templateUrl: 'components/slideshow/slide.html'
		transclude: true
		scope: {}
		bindToController:
			eventHandler: '&?'
		controllerAs: 'slide'
		controller: ['$scope', '$element', '$transclude', ($scope, $el, $transclude) ->
			@isShown = false

			@show = ( direction ) ->
				@direction = direction
				@isShown = true

			@hide = ( direction ) ->
				@direction = direction
				@isShown = false

			return this
		]
		link: ( $scope, $el, attrs, slideshowCtrl ) ->
			slideshowCtrl.addSlide( $scope.slide )
			return
]

