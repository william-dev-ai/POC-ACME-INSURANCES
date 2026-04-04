import {
  ComposedChart,
  Bar,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  Cell,
  ResponsiveContainer,
  ReferenceLine,
} from 'recharts'

const MAAND_KORT = {
  januari: 'Jan', februari: 'Feb', maart: 'Mrt', april: 'Apr',
  mei: 'Mei', juni: 'Jun', juli: 'Jul', augustus: 'Aug',
  september: 'Sep', oktober: 'Okt', november: 'Nov', december: 'Dec',
}

const CustomTooltip = ({ active, payload, label, schaal }) => {
  if (!active || !payload?.length) return null
  const factor = schaal === 'duizenden' ? 1000 : 1
  const suffix = schaal === 'duizenden' ? 'K' : ''
  const fmt = (v) => '€ ' + (v / factor).toLocaleString('nl-NL', { maximumFractionDigits: schaal === 'duizenden' ? 1 : 0 }) + suffix
  const isPiek = payload[0]?.payload?.is_piek

  return (
    <div style={{
      background: 'white', border: '1px solid #e1e4e8', borderRadius: 8,
      padding: '10px 14px', fontSize: 12, boxShadow: '0 4px 12px rgba(0,0,0,0.1)'
    }}>
      <div style={{ fontWeight: 700, marginBottom: 6, display: 'flex', alignItems: 'center', gap: 6 }}>
        {label}
        {isPiek && <span style={{ background: '#D85A30', color: 'white', padding: '1px 5px', borderRadius: 3, fontSize: 10 }}>PIEK</span>}
      </div>
      {payload.map((p) => (
        <div key={p.name} style={{ color: p.color, marginBottom: 2 }}>
          {p.name}: {fmt(p.value)}
        </div>
      ))}
    </div>
  )
}

export default function BarLineChart({ data, schaal, jaar }) {
  if (!data || data.length === 0) {
    return (
      <div className="card" style={{ height: 340, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <span style={{ color: '#6e7781' }}>Geen data beschikbaar voor de geselecteerde filters</span>
      </div>
    )
  }

  const factor = schaal === 'duizenden' ? 1000 : 1
  const suffix = schaal === 'duizenden' ? 'K' : ''
  const fmt = (v) => '€ ' + (v / factor).toLocaleString('nl-NL', { maximumFractionDigits: 0 }) + suffix

  const chartData = data.map((d) => ({
    ...d,
    naam: MAAND_KORT[d.maand] || d.maand,
  }))

  const pieken = data.filter((d) => d.is_piek)

  return (
    <div className="card">
      <div className="card-title">
        Ontwikkeling Bedrijfskosten {jaar}
        {pieken.length > 0 && (
          <span style={{ marginLeft: 8, background: '#D85A30', color: 'white', padding: '2px 8px', borderRadius: 4, fontSize: 10, fontWeight: 700 }}>
            Piek: {pieken.map(p => MAAND_KORT[p.maand] || p.maand).join(', ')}
          </span>
        )}
      </div>
      <ResponsiveContainer width="100%" height={300}>
        <ComposedChart data={chartData} margin={{ top: 5, right: 20, left: 20, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" vertical={false} />
          <XAxis dataKey="naam" tick={{ fontSize: 12, fill: '#6e7781' }} axisLine={false} tickLine={false} />
          <YAxis
            tickFormatter={(v) => fmt(v)}
            tick={{ fontSize: 11, fill: '#6e7781' }}
            axisLine={false}
            tickLine={false}
            width={80}
          />
          <Tooltip content={<CustomTooltip schaal={schaal} />} />
          <Legend
            iconType="circle"
            iconSize={8}
            wrapperStyle={{ fontSize: 12, paddingTop: 12 }}
          />

          <Bar dataKey="actual" name="Actual" radius={[3, 3, 0, 0]}>
            {chartData.map((entry, index) => (
              <Cell
                key={index}
                fill={entry.is_piek ? '#D85A30' : '#2563eb'}
              />
            ))}
          </Bar>

          <Bar dataKey="budget" name="Budget" fill="#d1d5db" radius={[3, 3, 0, 0]} />

          <Line
            dataKey="actual_ly"
            name="Actual vorig jaar"
            type="monotone"
            stroke="#16a34a"
            strokeWidth={2}
            strokeDasharray="5 4"
            dot={{ fill: '#16a34a', r: 3 }}
            activeDot={{ r: 5 }}
          />
        </ComposedChart>
      </ResponsiveContainer>
    </div>
  )
}
