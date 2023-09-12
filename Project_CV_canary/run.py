import cv2
from PIL import ImageGrab
import os
import detect
import mouse
import numpy as np

x1, y1, x2, y2 = 0, 0, 0, 0


def set_roi():
    global x1, y1, x2, y2
    print("사용하실 영역을 드래그 해주세요")
    while(mouse.is_pressed() == False):
        x1, y1 = mouse.get_position()
        while(mouse.is_pressed() == True):
            x2, y2 = mouse.get_position()
            while(mouse.is_pressed() == False):
                print("Your ROI : {0}, {1}, {2}, {3}".format(x1, y1, x2, y2))
                run()
                return



def run():
    while True:
            # 템포러리 파일 경로 설정
            temp_file = 'temp.jpg'

            # 현재 프레임 캡처 및 이미지 저장
            image = np.array(ImageGrab.grab(bbox=(x1, y1, x2, y2)))
            image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
            # 이미지 파일로 저장
            cv2.imwrite(temp_file, image)
            # 객체 감지 수행
            detect.run(weights='./best_0828_2.pt', source=temp_file, imgsz=(640, 640), conf_thres=0.45, exist_ok='./output/', view_img=True)
            key = cv2.waitKey(100)
            if key == ord("q"):
                print("Quit")
                break
            # 템포러리 파일 삭제
            os.remove(temp_file)
    cv2.destroyAllWindows()


set_roi()
# run()