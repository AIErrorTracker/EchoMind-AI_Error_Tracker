(function () {
  window.MockScenarioPresets = {
    baseline: {
      name: 'baseline',
      description: '接近演示数据的正常态'
    },
    stress: {
      name: 'stress',
      description: '文本、数字、列表综合压力测试'
    },
    edge: {
      name: 'edge',
      description: '极端边界测试（超长文本/高位数字/超大列表）'
    }
  };
})();
