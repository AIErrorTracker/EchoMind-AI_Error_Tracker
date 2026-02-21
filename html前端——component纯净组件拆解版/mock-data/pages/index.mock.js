(function () {
  window.PageMockDataRegistry = window.PageMockDataRegistry || {};
  window.PageMockDataRegistry['index'] = {
    baseline: {
      'top-dashboard': {
        stats: [
          { value: '3', label: '今日闭环' },
          { value: '2h25m', label: '学习时长' },
          { value: '12', label: '本周闭环' }
        ],
        prediction: {
          score: '63',
          total: '100',
          target: '70',
          hint: '目标 70 分 -- 查看预测详情',
          trend: [55, 57, 59, 61, 60, 63]
        },
        quickStart: {
          title: '快速开始',
          subtitle: '板块运动 (约5分钟)',
          route: 'model-training.html'
        }
      },
      'recommendation-list': {
        title: '推荐学习',
        items: [
          { icon: '!', iconTone: 'dark', title: '待诊断: 2025天津模拟 第5题', tags: ['待诊断', '上传于今日'], route: 'ai-diagnosis.html' },
          { icon: 'L1', iconTone: 'blue', title: '板块运动 -- 建模层训练', tags: ['本周错2次', '约5分钟'], route: 'model-detail.html' },
          { icon: 'KP', iconTone: 'gray', title: '库仑定律适用条件 -- 知识补强', tags: ['理解不深', '约3分钟'], route: 'knowledge-detail.html' },
          { icon: '~', iconTone: 'blue', title: '牛顿第二定律应用 -- 不稳定', tags: ['掌握不稳定', '14天未练习'], route: 'model-detail.html' }
        ]
      },
      'recent-upload': {
        title: '最近上传',
        subtitle: '3道错题未诊断',
        route: 'upload-history.html'
      }
    },
    stress: {
      'top-dashboard': {
        stats: [
          { value: '18', label: '今日闭环(压力测试)' },
          { value: '12h45m', label: '学习时长(压力测试)' },
          { value: '128', label: '本周闭环(压力测试)' }
        ]
      }
    },
    edge: {
      'top-dashboard': {
        prediction: {
          score: '638899',
          total: '100000',
          target: '700000',
          hint: '目标值极限边界验证：如果分数与目标都非常大，界面仍应保持可读和可交互。'
        }
      }
    }
  };
})();
