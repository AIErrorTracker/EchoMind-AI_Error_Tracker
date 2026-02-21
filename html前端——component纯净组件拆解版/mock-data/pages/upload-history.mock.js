(function () {
  window.PageMockDataRegistry = window.PageMockDataRegistry || {};
  window.PageMockDataRegistry['upload-history'] = {
    baseline: {
      'history-filter': {
        chips: ['全部', '待诊断', '已完成', '作业', '考试'],
        active: '全部'
      },
      'history-record-list': {
        groups: [
          {
            date: '今天',
            items: [
              { type: 'HW', label: '作业 -- 力学练习', desc: '3道错题 -- 1道已诊断, 2道待诊断', time: '14:30', status: '2待诊断', statusClass: 'tag tag-dark', route: 'question-detail.html' }
            ]
          },
          {
            date: '2月8日',
            items: [
              { type: 'EX', label: '2025天津模拟卷(一)', desc: '6道错题 -- 3道待诊断', time: '10:15', status: '3待诊断', statusClass: 'tag tag-dark' }
            ]
          },
          {
            date: '2月5日',
            items: [
              { type: 'HW', label: '作业 -- 电场练习', desc: '2道错题 -- 全部已诊断', time: '16:42', status: '已完成', statusClass: 'tag tag-gray' }
            ]
          },
          {
            date: '2月3日',
            items: [
              { type: 'EX', label: '2024天津高考真题', desc: '8道错题 -- 全部已诊断', time: '09:30', status: '已完成', statusClass: 'tag tag-gray' },
              { type: 'QK', label: '极简上传 -- 5道题', desc: '1道错题 -- 已诊断', time: '20:10', status: '已完成', statusClass: 'tag tag-gray' }
            ]
          }
        ]
      }
    },
    stress: {
      'history-filter': {
        active: '待诊断'
      }
    },
    edge: {
      'history-record-list': {
        groups: [
          {
            date: '今天',
            items: [
              { type: 'HW', label: '超长标题边界验证：这是一个用于列表项极端长度测试的作业记录名称', desc: '超长描述边界验证：本条记录包含大量文本用于测试换行、省略与整体布局下推行为是否正确。', time: '23:59', status: '999待诊断', statusClass: 'tag tag-dark', route: 'question-detail.html' }
            ]
          }
        ]
      }
    }
  };
})();
