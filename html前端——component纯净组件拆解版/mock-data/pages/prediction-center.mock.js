(function () {
  window.PageMockDataRegistry = window.PageMockDataRegistry || {};
  window.PageMockDataRegistry['prediction-center'] = {
    baseline: {
      'score-card': {
        predicted: '63',
        total: '100',
        target: '70',
        gapText: '差距: 7分 -- 预计 2-3 周可达成'
      },
      'trend-card': {
        labels: ['1月20日', '1月27日', '2月3日', '2月10日'],
        trend: [55, 57, 59, 61, 60, 63]
      },
      'score-path-table': {
        rows: [
          { title: '第5题', attitude: 'MUST', attitudeClass: 'attitude-must', action: '板块运动训练', delta: '+3', deltaClass: 'accent', route: 'question-aggregate.html' },
          { title: '第7题', attitude: 'MUST', attitudeClass: 'attitude-must', action: '电场综合训练', delta: '+3', deltaClass: 'accent', route: 'question-aggregate.html' },
          { title: '大题1', attitude: 'MUST', attitudeClass: 'attitude-must', action: '力学大题训练', delta: '+4', deltaClass: 'accent', route: 'question-aggregate.html' },
          { title: '大题2', attitude: 'TRY', attitudeClass: 'attitude-try', action: '前两问拿分', delta: '+2', deltaClass: 'gray', route: 'question-aggregate.html' },
          { title: '大题3', attitude: 'SKIP', attitudeClass: 'attitude-skip', action: '暂不投入', delta: '--', deltaClass: 'muted' }
        ]
      },
      'priority-model-list': {
        items: [
          { rank: 1, name: '板块运动', desc: '当前L1 -- 解决后预计 +5 分', route: 'model-detail.html' },
          { rank: 2, name: '库仑力平衡', desc: '当前L2 -- 解决后预计 +3 分', route: 'model-detail.html' },
          { rank: 3, name: '牛顿第二定律应用', desc: '当前L3 -- 不稳定 -- 稳定后预计 +2 分', route: 'model-detail.html' }
        ]
      }
    },
    stress: {
      'score-card': {
        predicted: '6388',
        total: '10000',
        target: '7000',
        gapText: '差距: 612 分 -- 建议优先清理题号簇和模型簇以快速回收分数。'
      }
    },
    edge: {
      'priority-model-list': {
        items: [
          { rank: 1, name: '极端边界模型名称验证：连续超长文本无空格ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', desc: '用于验证列表项在超长名称下的换行与布局稳定性。', route: 'model-detail.html' }
        ]
      }
    }
  };
})();
