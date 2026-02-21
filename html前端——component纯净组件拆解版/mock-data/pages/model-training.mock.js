(function () {
  window.PageMockDataRegistry = window.PageMockDataRegistry || {};
  window.PageMockDataRegistry['model-training'] = {
    baseline: {
      currentStep: 2,
      steps: [
        { title: '识别训练', subTitle: 'Step 1 / 6 -- 识别训练', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '决策训练', subTitle: 'Step 2 / 6 -- 决策训练', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '列式训练', subTitle: 'Step 3 / 6 -- 列式训练', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '陷阱辨析', subTitle: 'Step 4 / 6 -- 陷阱辨析', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '完整求解', subTitle: 'Step 5 / 6 -- 完整求解', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '变式训练', subTitle: 'Step 6 / 6 -- 变式训练', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' }
      ],
      'training-dialogue': {
        messages: [
          { role: 'ai', text: '上一步你成功识别了板块运动模型。现在，面对此类题目，你第一步做什么？' },
          { role: 'user', text: '先分析两个物体各自受力。' },
          { role: 'ai', text: '正确。再进一步，如何判断相对运动状态与共速时机？' }
        ],
        options: ['比较两个物体的加速度', '用相对速度判断', '不确定']
      }
    },
    stress: {
      currentStep: 5
    },
    edge: {
      currentStep: 6
    }
  };
})();
