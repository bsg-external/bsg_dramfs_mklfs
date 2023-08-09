
TARGET = dramfs_mklfs
LIBS = -lm
CC = gcc
CFLAGS = -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

dramfs_hdrs = \
	dramfs_fs.h \
	dramfs_fdtable.h \
	littlefs/lfs.h \
	littlefs/bd/lfs_rambd.h

dramfs_mkfs_srcs = \
	dramfs_mklfs.c \
	dramfs_util.c \
	littlefs/lfs.c \
	littlefs/lfs_util.c \
	littlefs/bd/lfs_rambd.c

OBJECTS  = $(patsubst %.c, %.o, $(dramfs_mkfs_srcs))
HEADERS  = $(dramfs_hdrs)

INCLUDES  = -Ilittlefs

%.o: %.c $(HEADERS)
	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(INCLUDES) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f littlefs/*.o
	-rm -f littlefs/bd/*.o
	-rm -f $(TARGET)
