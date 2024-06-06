FROM ubuntu:20.04

# Установить основные зависимости
RUN apt-get update && apt-get install -y \
  cmake \
  g++ \
  libgtest-dev \
  && rm -rf /var/lib/apt/lists/*

# Установить Google Test
RUN cd /usr/src/googletest && cmake . && make && cp -a include/gtest /usr/include && cp -a lib/libgtest*.a /usr/lib

# Копировать исходный код и выполнить сборку
WORKDIR /app
COPY . .

# Создать и перейти в директорию сборки, затем запустить CMake и Make
RUN mkdir -p _build && cd _build && cmake .. -DBUILD_TESTS=ON -DBUILD_COVERAGE=ON && make

# Команда по умолчанию
CMD ["./_build/my_executable"]
