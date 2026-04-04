export default function KPITiles({ data, schaal }) {
  if (!data) return null

  const factor = schaal === 'duizenden' ? 1000 : 1
  const suffix = schaal === 'duizenden' ? 'K' : ''

  const fmt = (val) => {
    if (val === null || val === undefined) return '—'
    const n = val / factor
    return '€ ' + n.toLocaleString('nl-NL', { maximumFractionDigits: schaal === 'duizenden' ? 1 : 0 }) + suffix
  }

  const fmtPct = (val) => {
    if (val === null || val === undefined) return '—'
    return (val > 0 ? '+' : '') + val.toFixed(1) + '%'
  }

  const afwijking = data.afwijking_bedrag || 0

  const tiles = [
    {
      label: 'Actual YTD',
      value: fmt(data.actual_ytd),
      sub: 'Werkelijk huidig jaar',
      cls: 'neutral',
    },
    {
      label: 'Budget YTD',
      value: fmt(data.budget_ytd),
      sub: 'Budget huidig jaar',
      cls: 'neutral',
    },
    {
      label: 'Afwijking',
      value: fmt(data.afwijking_bedrag),
      sub: 'Actual minus budget',
      cls: afwijking > 0 ? 'positive' : afwijking < 0 ? 'negative' : 'neutral',
    },
    {
      label: 'Afwijking %',
      value: fmtPct(data.afwijking_pct),
      sub: 'Ten opzichte van budget',
      cls: afwijking > 0 ? 'positive' : afwijking < 0 ? 'negative' : 'neutral',
    },
    {
      label: 'Actual FY LY',
      value: fmt(data.actual_fy_ly),
      sub: 'Volledig jaar vorig jaar',
      cls: 'neutral',
    },
    {
      label: 'Budget FY',
      value: fmt(data.budget_fy),
      sub: 'Volledig jaarbudget',
      cls: 'neutral',
    },
  ]

  return (
    <div className="kpi-grid">
      {tiles.map((t) => (
        <div key={t.label} className="kpi-card">
          <div className="kpi-label">{t.label}</div>
          <div className={`kpi-value ${t.cls}`}>{t.value}</div>
          <div className="kpi-sub">{t.sub}</div>
        </div>
      ))}
    </div>
  )
}
