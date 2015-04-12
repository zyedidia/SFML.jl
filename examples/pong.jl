using SFML

ball_radius = 15.0
ballmaxvelocity = 8.0

paddle_width = 80.0
paddle_height = 5.0
paddle_velocity = 6.0

window_width = 800
window_height = 600

red = Color(255, 0, 0)
white = Color(255, 255, 255)

type Ball
	shape::CircleShape
	velocity::Vector2f
end

function Ball(x, y)
	ball = Ball(CircleShape(), Vector2f(-ballmaxvelocity, -ballmaxvelocity))

	set_position(ball.shape, Vector2f(x, y))
	set_radius(ball.shape, ball_radius)
	set_fillcolor(ball.shape, red)
	set_origin(ball.shape, Vector2f(ball_radius, ball_radius))

	return ball
end

function update(ball::Ball)
	move(ball.shape, ball.velocity)

	position = get_position(ball.shape)
	x = position.x; y = position.y

	radius = get_radius(ball.shape)

	if x - radius < 0
		ball.velocity.x = ballmaxvelocity;
	elseif x + radius > window_width
		ball.velocity.x = -ballmaxvelocity;
	end

	if y - radius < 0
		ball.velocity.y = ballmaxvelocity;
	elseif y + radius > window_height
		ball.velocity.y = -ballmaxvelocity;
	end
end

type Paddle
	shape::RectangleShape
	velocity::Vector2f
	left::Int
	right::Int
end

function Paddle(x, y, left, right)
	paddle = Paddle(RectangleShape(), Vector2f(0.0, 0.0), left, right)

	set_position(paddle.shape, Vector2f(x, y))
	set_size(paddle.shape, Vector2f(paddle_width, paddle_height))
	set_fillcolor(paddle.shape, red)
	set_origin(paddle.shape, Vector2f(paddle_width / 2, paddle_height / 2))

	return paddle
end

function update(paddle::Paddle)
	move(paddle.shape, paddle.velocity)

	position = get_position(paddle.shape)
	x = position.x; y = position.y

	if (is_key_pressed(paddle.left))
		paddle.velocity.x = -paddle_velocity
	elseif (is_key_pressed(paddle.right))
		paddle.velocity.x = paddle_velocity
	else
		paddle.velocity.x = 0
	end
end

function intersects(ball::Ball, paddle::Paddle)
	radius = get_radius(ball.shape)
	ball_pos = get_position(ball.shape)
	paddle_pos = get_position(paddle.shape)
	ball_dis = Vector2f(abs(ball_pos.x - paddle_pos.x), abs(ball_pos.y - paddle_pos.y))

	paddle_size = get_size(paddle.shape)

	if ball_dis.x > (paddle_size.x + radius)
		return false;
	elseif ball_dis.y > (paddle_size.y + radius)
		return false
	else
		return true
	end
end

function main()
	ball = Ball(window_width / 2, window_height / 2)
	paddle1 = Paddle(window_width / 2, window_height - 50, KeyCode.LEFT, KeyCode.RIGHT)
	paddle2 = Paddle(window_width / 2, 50, KeyCode.A, KeyCode.D)

	sprites = Any[]
	push!(sprites, ball)
	push!(sprites, paddle1)
	push!(sprites, paddle2)

	window = RenderWindow("Arkanoid", window_width, window_height)
	set_framerate_limit(window, 60)
	set_vsync_enabled(window, true)

	event = Event()

	while isopen(window)
		while pollevent(window, event)
			if get_type(event) == EventType.CLOSE
				close(window)
			end
		end

		clear(window, white)

		if intersects(ball, paddle1) || intersects(ball, paddle2)
			ball.velocity.y = -ball.velocity.y
		end

		for i in 1:length(sprites)
			update(sprites[i])

			draw(window, sprites[i].shape)
		end

		display(window)
	end
end

main()
