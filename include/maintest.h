#ifndef __MAIN_TEST_H__
#define __MAIN_TEST_H__

#define DET_MODEL "models/dbnet_op"
#define CLS_MODEL "models/angle_op"
#define REC_MODEL "models/crnn_lite_op"
#define KEY_FILE  "models/keys.txt"

#define THREAD_NUM 3

#ifdef WIN32
const char* DEFAULT_IMG_PATH = "images\\";
#else
const char *DEFAULT_IMG_PATH = "images/";
#endif

const char *DEFAULT_IMG_NAME = "1.jpg";

#endif //__MAIN_TEST_H__
