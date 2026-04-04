import { useState, useEffect, useCallback } from 'react'
import axios from 'axios'
import './index.css'
import KPITiles from './components/KPITiles'
import BarLineChart from './components/BarLineChart'
import Findings from './components/Findings'
import AIAssistant from './components/AIAssistant'

const API = import.meta.env.VITE_API_URL || 'http://localhost:8000'

const DEFAULT_FILTERS = {
  divisie: '',
  onderdeel: '',
  kostenplaats_id: '',
  kostensoort: '',
  label: '',
  jaar: '2026',
  schaal: 'eenheden',
}

export default function App() {
  const [filters, setFilters] = useState(DEFAULT_FILTERS)
  const [filterOptions, setFilterOptions] = useState(null)
  const [kpiData, setKpiData] = useState(null)
  const [chartData, setChartData] = useState([])
  const [findings, setFindings] = useState('')
  const [findingsLoading, setFindingsLoading] = useState(false)

  // Filter opties laden
  useEffect(() => {
    axios.get(`${API}/api/filters`).then((r) => setFilterOptions(r.data))
  }, [])

  // KPI + Chart laden bij filterwijziging
  const loadData = useCallback(async () => {
    const params = {
      ...(filters.divisie && { divisie: filters.divisie }),
      ...(filters.onderdeel && { onderdeel: filters.onderdeel }),
      ...(filters.kostenplaats_id && { kostenplaats_id: parseInt(filters.kostenplaats_id) }),
      ...(filters.kostensoort && { kostensoort: filters.kostensoort }),
      ...(filters.label && { label: filters.label }),
      jaar: filters.jaar,
    }

    const [kpi, chart] = await Promise.all([
      axios.get(`${API}/api/kpi`, { params }),
      axios.get(`${API}/api/chart`, { params }),
    ])
    setKpiData(kpi.data)
    setChartData(chart.data.data || [])
  }, [filters])

  useEffect(() => {
    loadData()
  }, [loadData])

  // Bevindingen laden (debounced)
  useEffect(() => {
    setFindingsLoading(true)
    const timer = setTimeout(async () => {
      try {
        const res = await axios.post(`${API}/api/findings`, {
          divisie: filters.divisie || null,
          onderdeel: filters.onderdeel || null,
          kostenplaats_id: filters.kostenplaats_id ? parseInt(filters.kostenplaats_id) : null,
          kostensoort: filters.kostensoort || null,
          label: filters.label || null,
          jaar: filters.jaar,
        })
        setFindings(res.data.findings)
      } catch {
        setFindings('Kon bevindingen niet ophalen.')
      } finally {
        setFindingsLoading(false)
      }
    }, 800)
    return () => clearTimeout(timer)
  }, [filters])

  const setFilter = (key, val) => setFilters((f) => ({ ...f, [key]: val }))
  const resetFilters = () => setFilters(DEFAULT_FILTERS)

  // Gefilterde kostenplaatsen op basis van divisie/onderdeel
  const gefilterdKP = filterOptions?.kostenplaatsen?.filter((kp) => {
    if (filters.divisie && kp.divisie !== filters.divisie) return false
    if (filters.onderdeel && kp.onderdeel !== filters.onderdeel) return false
    return true
  }) || []

  return (
    <>
      {/* Header */}
      <div className="header">
        <div className="header-logo">
          <div className="header-logo-mark">A</div>
          <div>
            <div className="header-title">ACME Insurances</div>
            <div className="header-subtitle">Control Generieke Diensten</div>
          </div>
        </div>
        <div className="header-badge">Ontwikkeling Bedrijfskosten</div>
      </div>

      <div className="main-content">
        {/* Filter bar */}
        <div className="filter-bar">
          <div className="filter-group">
            <label>Jaar</label>
            <select value={filters.jaar} onChange={(e) => setFilter('jaar', e.target.value)}>
              <option value="2026">2026</option>
              <option value="2025">2025</option>
            </select>
          </div>

          <div className="filter-group">
            <label>Divisie</label>
            <select value={filters.divisie} onChange={(e) => { setFilter('divisie', e.target.value); setFilter('onderdeel', ''); setFilter('kostenplaats_id', '') }}>
              <option value="">Alle divisies</option>
              {filterOptions?.divisies?.map((d) => <option key={d}>{d}</option>)}
            </select>
          </div>

          <div className="filter-group">
            <label>Onderdeel</label>
            <select value={filters.onderdeel} onChange={(e) => { setFilter('onderdeel', e.target.value); setFilter('kostenplaats_id', '') }}>
              <option value="">Alle onderdelen</option>
              {[...new Set(gefilterdKP.map((k) => k.onderdeel))].map((o) => <option key={o}>{o}</option>)}
            </select>
          </div>

          <div className="filter-group" style={{ minWidth: 180 }}>
            <label>Kostenplaats</label>
            <select value={filters.kostenplaats_id} onChange={(e) => setFilter('kostenplaats_id', e.target.value)}>
              <option value="">Alle kostenplaatsen</option>
              {gefilterdKP.map((kp) => <option key={kp.id} value={kp.id}>{kp.id} — {kp.omschrijving}</option>)}
            </select>
          </div>

          <div className="filter-group" style={{ minWidth: 160 }}>
            <label>Kostensoort</label>
            <select value={filters.kostensoort} onChange={(e) => setFilter('kostensoort', e.target.value)}>
              <option value="">Alle kostensoorten</option>
              {filterOptions?.kostensoorten?.map((k) => <option key={k}>{k}</option>)}
            </select>
          </div>

          <div className="filter-group">
            <label>Label</label>
            <select value={filters.label} onChange={(e) => setFilter('label', e.target.value)}>
              <option value="">Alle labels</option>
              {filterOptions?.labels?.map((l) => <option key={l}>{l}</option>)}
            </select>
          </div>

          <div className="filter-group">
            <label>Schaal</label>
            <select value={filters.schaal} onChange={(e) => setFilter('schaal', e.target.value)}>
              <option value="eenheden">EUR (eenheden)</option>
              <option value="duizenden">EUR (duizendtallen)</option>
            </select>
          </div>

          <button className="filter-reset" onClick={resetFilters}>↺ Reset</button>
        </div>

        {/* KPI Tiles */}
        <KPITiles data={kpiData} schaal={filters.schaal} />

        {/* Chart + Findings */}
        <div className="dashboard-row">
          <BarLineChart data={chartData} schaal={filters.schaal} jaar={filters.jaar} />
          <Findings text={findings} loading={findingsLoading} />
        </div>

        {/* AI Assistent */}
        <AIAssistant />
      </div>
    </>
  )
}
