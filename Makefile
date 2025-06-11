# 编译器和编译选项
CXX := g++
CXXFLAGS := -std=c++11 -Wall -Wextra -pthread
DEBUG_FLAGS := -g -O0
RELEASE_FLAGS := -O3 -DNDEBUG

# 源文件和头文件目录
SRC_DIRS := ./scheduler ./fiber ./thread
INCLUDE_DIRS := $(SRC_DIRS)

# 使用通配符查找所有源文件和头文件
SRCS := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.cpp))
HEADERS := $(foreach dir,$(INCLUDE_DIRS),$(wildcard $(dir)/*.h))

# 测试文件
TEST_SRCS := $(wildcard *_test.cpp)
TEST_BINS := $(TEST_SRCS:%.cpp=%)

	@echo "TEST_SRCS=$(TEST_SRCS)   TEST_BINS=$(TEST_BINS)"

# 头文件包含路径
INCLUDES := $(foreach dir,$(INCLUDE_DIRS),-I$(dir))

# 默认目标：编译所有测试程序
all: debug

# 调试版本
debug: CXXFLAGS += $(DEBUG_FLAGS)
debug: $(TEST_BINS)

# 发布版本
release: CXXFLAGS += $(RELEASE_FLAGS)
release: $(TEST_BINS)

# 编译测试程序的规则
# 这里添加 echo 语句，先打印要执行的编译命令，再实际执行
%: %.cpp $(SRCS) $(HEADERS)
	@echo "编译命令: $(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $< $(filter-out $<,$(SRCS))"
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $< $(filter-out $<,$(SRCS))

# 清理目标
clean:
	rm -f $(TEST_BINS)

# 显示源文件列表（用于调试）
show:
	@echo "源文件: $(SRCS)"
	@echo "测试文件: $(TEST_SRCS)"
	@echo "目标文件: $(TEST_BINS)"