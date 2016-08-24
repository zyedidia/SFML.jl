using SFML

ball_radius = 15.0
ballmaxvelocity = 8.0

paddle_width = 80.0
paddle_height = 5.0
paddle_velocity = 6.0

window_width = 800
window_height = 600

type Score
    paddle1::Int
    paddle2::Int
end

type Ball
    shape::CircleShape
    velocity::Vector2f
    starting_pos::Vector2f
end

function Ball(x, y)
    ball = Ball(CircleShape(), Vector2f(-ballmaxvelocity, -ballmaxvelocity), Vector2f(x, y))

    set_position(ball.shape, ball.starting_pos)
    set_radius(ball.shape, ball_radius)
    set_fillcolor(ball.shape, SFML.red)
    set_origin(ball.shape, Vector2f(ball_radius, ball_radius))

    return ball
end

function reset(ball::Ball)
    set_position(ball.shape, ball.starting_pos)
    ball.velocity = Vector2f(-ballmaxvelocity, -ballmaxvelocity)
end

function update(ball::Ball, score::Score)
    move(ball.shape, ball.velocity)

    position = get_position(ball.shape)
    x = position.x; y = position.y

    radius = get_radius(ball.shape)

    if x - radius < 0
        ball.velocity = Vector2f(ballmaxvelocity, ball.velocity.y)
    elseif x + radius > window_width
        ball.velocity = Vector2f(-ballmaxvelocity, ball.velocity.y)
    end

    if y - radius < 0
        score.paddle2 += 1
        # reset(ball)
        # sleep(1)
        ball.velocity = Vector2f(ball.velocity.x, ballmaxvelocity)
    elseif y + radius > window_height
        score.paddle1 += 1
        # reset(ball)
        # sleep(1)
        ball.velocity = Vector2f(ball.velocity.x, -ballmaxvelocity)
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
    set_fillcolor(paddle.shape, SFML.red)
    set_origin(paddle.shape, Vector2f(paddle_width / 2, paddle_height / 2))

    return paddle
end

function update(paddle::Paddle)
    move(paddle.shape, paddle.velocity)

    position = get_position(paddle.shape)
    x = position.x; y = position.y
    vy = paddle.velocity.y
    if (is_key_pressed(paddle.left))
        paddle.velocity = Vector2f(-paddle_velocity, vy)
    elseif (is_key_pressed(paddle.right))
        paddle.velocity = Vector2f(paddle_velocity, vy)
    else
        paddle.velocity = Vector2f(0, vy)
    end
end

function collides(ball::Ball, paddle::Paddle)
    ballbounds = get_globalbounds(ball.shape)
    paddlebounds = get_globalbounds(paddle.shape)

    return intersects(ballbounds, paddlebounds)
end

function main()
    score = Score(0, 0)

    score_text = RenderText()
    set_string(score_text, "$(score.paddle1)\n\n\n$(score.paddle2)")
    set_color(score_text, Color(255, 0, 0))
    set_position(score_text, Vector2f(60, window_height / 4))
    set_charactersize(score_text, 50)

    ball = Ball(window_width / 2, window_height / 2)
    paddle1 = Paddle(window_width / 2, window_height - 50, KeyCode.LEFT, KeyCode.RIGHT)
    paddle2 = Paddle(window_width / 2, 50, KeyCode.A, KeyCode.D)

    paddles = Paddle[]
    push!(paddles, paddle1)
    push!(paddles, paddle2)

    window = RenderWindow("Pong", window_width, window_height)
    set_framerate_limit(window, 60)
    set_vsync_enabled(window, true)

    event = Event()

    while isopen(window)
        while pollevent(window, event)
            if get_type(event) == EventType.CLOSED
                close(window)
            end
        end

        set_string(score_text, "$(score.paddle1)\n\n\n$(score.paddle2)")

        clear(window, SFML.white)

        if collides(ball, paddle1) || collides(ball, paddle2)
            ball.velocity = Vector2f(ball.velocity.x, -ball.velocity.y)
        end

        update(ball, score)
        draw(window, ball.shape)
        for i in 1:length(paddles)
            update(paddles[i])
            draw(window, paddles[i].shape)
        end

        draw(window, score_text)
        display(window)
    end
end

main()
