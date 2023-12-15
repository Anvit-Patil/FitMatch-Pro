% Fitness goals
fitness_goal(weight_loss).
fitness_goal(muscle_gain).
fitness_goal(endurance).
fitness_goal(flexibility).

% Fitness levels
fitness_level(beginner).
fitness_level(intermediate).
fitness_level(advanced).

% Health constraints
health_constraint(none).
health_constraint(cardiovascular).
health_constraint(joint_pain).
health_constraint(back_pain).

% Equipment availability
equipment(none).
equipment(basic).
equipment(full_gym).

% Workout types
workout_type(cardio).
workout_type(strength).
workout_type(hiit).  
workout_type(yoga).
workout_type(pilates).
workout_type(walking).
workout_type(swimming).

% Time availability (in minutes)
time_available(15).
time_available(30).
time_available(45).
time_available(60).

% General rule for workout recommendation
recommend_workout(Goal, Level, Health, Equipment, Time, WorkoutType) :-
    fitness_goal(Goal),
    fitness_level(Level),
    health_constraint(Health),
    equipment(Equipment),
    time_available(ApproxTime),
    (
        suitable_workout(Goal, Level, Health, Equipment, Time, WorkoutType) ;
        (   approximate_time_slot(Time, ApproxTime),
            suitable_workout(Goal, Level, Health, Equipment, ApproxTime, WorkoutType)
        )
    ).

% Specific rules considering various aspects
suitable_workout(weight_loss, beginner, none, _, 30, walking).
suitable_workout(weight_loss, intermediate, none, basic, 45, hiit).
suitable_workout(weight_loss, advanced, none, full_gym, 60, cardio).

suitable_workout(muscle_gain, beginner, none, basic, 30, strength).
suitable_workout(muscle_gain, intermediate, none, full_gym, 45, strength).
suitable_workout(muscle_gain, advanced, none, full_gym, 60, strength).

suitable_workout(endurance, _, none, _, 30, cardio).
suitable_workout(endurance, _, none, _, 45, hiit).

suitable_workout(flexibility, _, none, _, 30, yoga).
suitable_workout(flexibility, _, none, _, 45, pilates).

% Considering health constraints
suitable_workout(_, _, cardiovascular, _, _, swimming).
suitable_workout(_, _, joint_pain, _, _, swimming).
suitable_workout(_, _, back_pain, _, _, pilates).

% Approximate time
approximate_time_slot(RequestedTime, ApproxTime) :-
    (   RequestedTime =< 22 -> ApproxTime = 15
    ;   RequestedTime =< 38 -> ApproxTime = 30
    ;   RequestedTime =< 52 -> ApproxTime = 45
    ;   ApproxTime = 60
    ).

% ... Additional can be added as per requirements
