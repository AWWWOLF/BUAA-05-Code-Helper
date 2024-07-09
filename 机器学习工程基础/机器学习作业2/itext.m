function mat = itext(imgPath, modelPath)
    test_image = imread(imgPath);
    shape = size(test_image);
    dimension = numel(shape);
    if dimension > 2
        test_image = rgb2gray(test_image); %灰度化
    end
    test_image = imresize(test_image, [28,28]); %保证输入为28*28
    test_iamge = imbinarize(test_image,0.5); %二值化
    test_image = imcomplement(test_image); %反转，使得输入网络时一定要保证图片、
    % 背景是黑色，数字部分是白色
    %imshow(test_image);

    load(modelPath);
    % test_result = Recognition(trainNet, test_image);
    test_result = classify(trainLeNet, test_image);
    mat = test_result;
end