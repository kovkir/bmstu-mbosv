proctype check_triangle_type(int a, b, c) {
    // Проверка на существование треугольника
    if
    :: (a + b > c && a + c > b && b + c > a) -> {
        // Сортируем стороны, чтобы C всегда была самой большой
        if
        :: (a > b && a > c) -> {
            int temp = a;
            a = c;
            c = temp;
        }
        :: (b > a && b > c) -> {
            int temp = b;
            b = c;
            c = temp;
        }
        :: else -> skip;
        fi;

        // Проверка типа треугольника
        if
        :: (a * a + b * b == c * c) -> printf("Прямоугольный треугольник\n");
        :: (a * a + b * b > c * c) -> printf("Остроугольный треугольник\n");
        :: else -> printf("Тупоугольный треугольник\n");
        fi;
    }
    :: else -> printf("Это не треугольник\n");
    fi;
}

init {
    // Пример вызова программы с разными сторонами
    run check_triangle_type(3, 4, 5);  // Прямоугольный треугольник
    run check_triangle_type(5, 5, 8);  // Тупоугольный треугольник
    run check_triangle_type(3, 3, 4);  // Остроугольный треугольник
    run check_triangle_type(1, 2, 3);  // Это не треугольник
}
