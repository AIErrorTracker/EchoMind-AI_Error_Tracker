(function () {
  window.PageMockDataRegistry = window.PageMockDataRegistry || {};
  window.PageMockDataRegistry['knowledge-learning'] = {
    baseline: {
      currentStep: 3,
      steps: [
        { title: '概念呈现', subTitle: 'Step 1 / 5 -- 概念呈现', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '理解检查', subTitle: 'Step 2 / 5 -- 理解检查', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '辨析训练', subTitle: 'Step 3 / 5 -- 辨析训练', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '实际应用', subTitle: 'Step 4 / 5 -- 实际应用', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' },
        { title: '概念检测', subTitle: 'Step 5 / 5 -- 概念检测', note: '本步骤只切换顶部 step 模块，下面对话区保持不变' }
      ],
      'learning-dialogue': {
        messages: [
          { role: 'ai', text: '库仑定律和万有引力定律都是平方反比定律。你先说说它们的核心差异。' },
          { role: 'user', text: '一个关于电荷，一个关于质量。' },
          { role: 'ai', text: '很好。再说说库仑定律的适用条件，是否能用于任何带电体？' }
        ],
        options: ['能，球壳可以看成点电荷', '不能，这不满足适用条件', '不确定，再解释一下']
      }
    },
    stress: {
      currentStep: 4
    },
    edge: {
      currentStep: 5
    }
  };
})();
