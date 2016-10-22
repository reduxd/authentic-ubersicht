# Authentic Weather for Übersicht
# reduxd, 2015

# ------------------------------ CONFIG ------------------------------

# forecast.io api key
apiKey: ''

# degree units; 'c' for celsius, 'f' for fahrenheit
unit: 'c'

# icon set; 'black', 'white', and 'blue' supported
icon: 'white'

# weather icon above text; true or false
showIcon: true

# temperature above text; true or false
showTemp: false

# refresh every '(60 * 1000)  * x' minutes
refreshFrequency: (60 * 1000) * 10

# ---------------------------- END CONFIG ----------------------------

exclude: "minutely,hourly,alerts,flags"

command: "echo {}"

makeCommand: (apiKey, location) ->
  "curl -sS 'https://api.forecast.io/forecast/#{apiKey}/#{location}?units=si&exclude=#{@exclude}'"

render: (o) -> """
	<article id="content">

		<!-- snippet -->
		<div id="snippet">
		</div>

		<!--phrase text box -->
		<h1>
		</h1>

		<!-- subline text box -->
		<h2>
		</h2>
	</article>
"""

afterRender: (domEl) ->
  geolocation.getCurrentPosition (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand(@apiKey, "#{lat},#{lon}")

    @refresh()

update: (o, dom) ->
	# parse command json
	data = JSON.parse(o)

	return unless data.currently?
	# get current temp from json
	t = data.currently.temperature

	# process condition data (1/2)
	s1 = data.currently.icon
	s1 = s1.replace(/-/g, "_")

	# snippet control

	snippetContent = []

	# icon dump from android app
	if @showIcon
		snippetContent.push "<img src='authentic.widget/icon/#{ @icon }/#{ s1 }.png'></img>"

	if @showTemp
		if @unit == 'f'
			snippetContent.push "#{ Math.round(t * 9 / 5 + 32) } °F"
		else
			snippetContent.push "#{ Math.round(t) } °C"

	$(dom).find('#snippet').html snippetContent.join ''

	# process condition data (2/2)
	s1 = s1.replace(/(day)/g, "")
	s1 = s1.replace(/(night)/g, "")
	s1 = s1.replace(/_/g, " ")
	s1 = s1.trim()

	# get relevant phrase
	@parseStatus(s1, t, dom)

# phrases dump from android app
parseStatus: (summary, temperature, dom) ->
	c = []
	s = []
	$.getJSON 'authentic.widget/phrases.json', (data) ->
		$.each data.phrases, (key, val) ->
			# condition based
			if val.condition == summary
				if val.min < temperature
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

				if typeof val.min == 'undefined'
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

			# temp based
			if typeof val.condition == 'undefined'
				if val.min < temperature
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

				if typeof val.min == 'undefined'
					if val.max > temperature
						c.push val
						s.push key

					if typeof val.max == 'undefined'
						c.push val
						s.push key

		r = c[Math.floor(Math.random()*c.length)]

		title = r.title
		highlight = r.highlight[0]
		color = r.color
		sub = r.subline
		nextTest = s[Math.floor(Math.random()*c.length)]

		text = title.replace(/\|/g, " ")

		c1 = new RegExp(highlight, "g")
		c2 = "<i style=\"color:" + color + "\">" + highlight + "</i>"

		text2 = text.replace(c1, c2)
		text3 = text2.replace(/>\?/g, ">")

		$(dom).find('h1').html text3
		$(dom).find('h2').html sub

# adapted from authenticweather.com
style: """
	width 20%
	bottom 1%
	left 1%
	font-family 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, 'Open Sans', sans-serif
	font-smooth always
	color #ffffff

	#snippet
		font-size 2em
		font-weight 500

		img
			max-width 100px

	h1
		font-size 3.3em
		font-weight 600
		line-height 1em
		letter-spacing -0.04em
		margin 0 0 0 0

	h2
		font-weight 500
		font-size 1em

	i
		font-style normal
"""
