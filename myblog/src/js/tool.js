function undefine(i) {
  if ('undefined' == typeof i) {
    return true
  } else {
    return false
  }
}

function nullZeroBlank(i) {
  if (i == null) return true
  else if (typeof i == 'string') {
    let str = i.replace(/\[\]/g, ' ').trim()
    if (str.length == 0) return true
  } else if (i == 0) return true

  return false
}

function notNullZeroBlank(i) {
  return !nullZeroBlank(i)
}

// src/js/tool.js

function dateFormat(dateString, format) {
  try {
    let date = new Date(dateString)
    if ('yyyy-MM-dd' == format) {
      let dateFormat = date.getFullYear() + '-'
      // 修复：月份需要 +1
      dateFormat += date.getMonth() + 1 + '-'
      dateFormat += date.getDate()
      return dateFormat
    } else {
      return '无此格式！'
    }
  } catch (e) {
    return '格式转换错误！'
  }
}
// ... 保持其他代码不变

export {
  undefine, // 此处声明外部可调用的方法。未在此处声明的方法，外部无法调用。
  nullZeroBlank,
  notNullZeroBlank,
  dateFormat,
}
