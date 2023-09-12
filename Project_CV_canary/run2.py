from PIL import ImageGrab
import cv2
import keyboard
import mouse
import numpy as np
import os
import pyautogui

import detect


# def set_roi():
#     global ROI_SET, x1, y1, x2, y2
#     ROI_SET = False
#     print("Select your ROI using mouse drag.")
#     while(mouse.is_pressed() == False):
#         x1, y1 = mouse.get_position()
#         while(mouse.is_pressed() == True):
#             x2, y2 = mouse.get_position()
#             while(mouse.is_pressed() == False):
#                 print("Your ROI : {0}, {1}, {2}, {3}".format(x1, y1, x2, y2))
#                 ROI_SET = True
#                 return

def set_roi():
    global ROI_SET, x1, y1, x2, y2

    ROI_SET = False
    print("Select your ROI using mouse drag.")
    # while not mouse.is_pressed():
    #     x1, y1 = mouse.get_position()
    #     while mouse.is_pressed():
    #         x2, y2 = mouse.get_position()
    while True:
            # 꼭지점 좌표와 크기 계산
            left = min(x1, x2)
            top = min(y1, y2)
            width = max(x1, x2) - left
            height = max(y1, y2) - top

            kwargs = {'left': left, 'top': top, 'width': width, 'height': height}
            pyautogui.displayMousePosition()  # 현재 마우스 위치 출력
            pyautogui.drawRectangle(**kwargs)  # 지정한 위치에 사각형 그리기

        # while not mouse.is_pressed():
        #     ROI_SET = True
        #     return (left, top, width, height)
            ROI_SET = True
            return None


ROI_SET = False
x1, y1, x2, y2 = 100, 100, 500, 500

set_roi()

while True:
    if ROI_SET == True:
        # 템포러리 파일 경로 설정
        temp_file = "temp.jpg"
        # 현재 프레임 캡처 및 이미지 저장
        image = np.array(ImageGrab.grab(bbox=(x1, y1, x2, y2)))
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
        # 이미지 파일로 저장
        cv2.imwrite(temp_file, image)

        # 객체 감지 수행
        predictions = detect.run(weights='./best.pt', source=temp_file, imgsz=(x2-x1, y2-y1), conf_thres=0.25, exist_ok='./output/')
        image2 = cv2.imread('runs/detect/exp/temp.jpg')
        cv2.imshow("pred", image2)

        key = cv2.waitKey(100)

        if key == ord("q"):
            print("Quit")
            break

        # 템포러리 파일 삭제
        os.remove(temp_file)

cv2.destroyAllWindows()

