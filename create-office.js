// wd create-entity create-office.js "Minister for X"
module.exports = (label) => {
  return {
    type: 'item',
    labels: {
      en: label,
    },
    descriptions: {
      en: 'position in the Cabinet of Bulgaria',
    },
    claims: {
      P31:   { value: 'Q294414' }, // instance of: public office
      P279:  { value: 'Q83307'  }, // subclas of: minister
      P17:   { value: 'Q219'    }, // country: Bulgaria
      P1001: { value: 'Q219'    }, // jurisdiction: Bulgaria
      P361: {
        value: 'Q2396053',          // part of: Council of Ministers
        references: {
          P854: 'https://www.gov.bg/en/Cabinet/CABINET-MEMBERS'
        },
      }
    }
  }
}
