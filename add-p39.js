module.exports = (id, position, personname, positionname) => {
  reference = {
    P854: 'https://www.gov.bg/en/Cabinet/CABINET-MEMBERS',
    P1476: {
      text: 'CARETAKER CABINET MEMBERS',
      language: 'en',
    },
    P813: new Date().toISOString().split('T')[0],
    P407: 'Q1860', // language: English
  }
  if(personname)     reference['P1810'] = personname
  if(positionname)   reference['P1932'] = positionname

  return {
    id,
    claims: {
      P39: {
        value: position,
        qualifiers: {
          P580: '2021-05-12',
          P5054: 'Q106803620' // Yanev Government
        },
        references: reference,
      }
    }
  }
}
