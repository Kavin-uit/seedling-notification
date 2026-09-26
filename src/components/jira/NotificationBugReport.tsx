import React, { useState } from 'react'
import {
  AlertTriangle,
  Check,
  Share2,
  Printer,
  CheckCircle2,
  BookOpen,
} from 'lucide-react'

interface NotificationBugReportProps {
  onShowToast?: (msg: string) => void
  onNavigateToRuleBook?: () => void
}

interface BugItem {
  id: string
  title: string
  engine: string
  ruleId?: string
  severity: 'High' | 'Medium'
  category: 'Broken Navigation' | 'Missing Dynamic Data' | 'Missing Security Metadata'
  description: string
  actualBehavior: string
  expectedBehavior: string
  imageSrc?: string
  imageAlt?: string
}

export const NotificationBugReport: React.FC<NotificationBugReportProps> = ({
  onShowToast,
  onNavigateToRuleBook,
}) => {
  const [copiedLink, setCopiedLink] = useState(false)
  const [activeImageModal, setActiveImageModal] = useState<string | null>(null)

  const bugs: BugItem[] = [
    {
      id: 'BUG-01',
      title: 'Co-Sponsor Invite: "Respond" Button Navigation Broken',
      engine: 'Participation Engine',
      ruleId: 'CI-PART-041',
      severity: 'High',
      category: 'Broken Navigation',
      description:
        'When a user receives a co-sponsorship invitation email, clicking the primary "Respond" call-to-action button fails to navigate or deep link.',
      actualBehavior:
        'Clicking "Respond" fails to route (the link does not resolve or leads to an empty/unhandled state).',
      expectedBehavior:
        'Must redirect directly to the Invite Acceptance Page (/invite/{inviteToken}/accept or trigger the native mobile app screen with the invitation token pre-loaded).',
      imageSrc: '/bugs/01_co_sponsor_invite_broken_respond.png',
      imageAlt: 'You have Been Invited Email - Broken Respond Button',
    },
    {
      id: 'BUG-02',
      title: 'Invite Accepted: Invitee User Name Missing from Body Copy',
      engine: 'Participation Engine',
      ruleId: 'CI-PART-042',
      severity: 'Medium',
      category: 'Missing Dynamic Data',
      description:
        'When an invitee accepts a co-sponsorship, the notification email sent to the sponsor is missing the invitee’s name at the beginning of the sentence.',
      actualBehavior:
        'Body text displays: "has accepted your invitation to co-sponsor -- welcome them to the team and start growing good together."',
      expectedBehavior:
        'Must dynamically inject the invitee’s display name: "[Username] has accepted your invitation to co-sponsor -- welcome them to the team and start growing good together."',
      imageSrc: '/bugs/02_invite_accepted_missing_username.png',
      imageAlt: 'Your Invitation Was Accepted - Missing Username',
    },
    {
      id: 'BUG-03',
      title: 'New Device Detected: Missing Critical Security & Login Details',
      engine: 'Identity Engine',
      ruleId: 'ID-24',
      severity: 'High',
      category: 'Missing Security Metadata',
      description:
        'The security alert email "New Device Detected" provides only generic warning text and omits standard device/session verification metadata.',
      actualBehavior:
        'Only says: "We noticed a sign-in from a new device. If it was you, there\'s nothing else to do. If not, please secure your account right away."',
      expectedBehavior:
        'Must display critical sign-in metadata in the email body: Device Name/Model, Operating System & Browser, IP Address, Approximate Location (City/Country), and Timestamp so the user can verify the activity before clicking "Review Activity".',
      imageSrc: '/bugs/03_new_device_detected_missing_info.png',
      imageAlt: 'New Device Detected - Missing Metadata',
    },
    {
      id: 'BUG-04',
      title: 'Profile Updated: "View Profile" Button Navigation Broken',
      engine: 'Identity Engine',
      ruleId: 'ID-25',
      severity: 'High',
      category: 'Broken Navigation',
      description:
        'Following a profile edit, the confirmation email "Profile Updated" contains a "View Profile" button that fails to redirect to the user profile.',
      actualBehavior:
        'Clicking "View Profile" does not route to the profile view.',
      expectedBehavior:
        'Must deep link directly to the user\'s Profile Screen (/profile or in-app profile view).',
      imageSrc: '/bugs/04_profile_updated_broken_view_profile.png',
      imageAlt: 'Profile Updated - Broken View Profile Navigation',
    },
    {
      id: 'BUG-05',
      title: 'ID-25 Specification: "Username Changed" Action Failing',
      engine: 'Identity Engine',
      ruleId: 'ID-25',
      severity: 'High',
      category: 'Broken Navigation',
      description:
        'Master Rule ID-25 defines the notification policy for username changes. The in-app message and redirect action are not executing as specified in the rulebook.',
      actualBehavior:
        'The notification delivery and the required action ("take user to profile") are failing.',
      expectedBehavior:
        'In-App & Email must trigger on username update: "Your username has been updated and is now live across Seedling. BOX: View Profile", redirecting directly to user profile.',
    },
  ]

  const handleCopyShareLink = () => {
    const url = `${window.location.origin}${window.location.pathname}?view=bugs`
    navigator.clipboard.writeText(url).then(() => {
      setCopiedLink(true)
      setTimeout(() => setCopiedLink(false), 2500)
      if (onShowToast) {
        onShowToast('Direct manager link copied to clipboard!')
      }
    })
  }

  const handlePrint = () => {
    window.print()
  }

  return (
    <div className="flex-1 overflow-y-auto bg-[#F8F9FA] text-[#172B4D] font-sans">
      {/* Top Breadcrumb & Actions Bar */}
      <div className="bg-white border-b border-[#DFE1E6] px-4 sm:px-6 py-3 shrink-0">
        <div className="max-w-5xl mx-auto flex flex-wrap items-center justify-between gap-3">
          <div className="flex items-center gap-2 text-xs text-slate-500">
            <span className="font-semibold text-slate-800">Seedling QA</span>
            <span>/</span>
            <span>Bug Reports</span>
            <span>/</span>
            <span className="font-mono text-slate-900 font-bold">NOTIFICATION-DEEP-LINKS</span>
          </div>

          <div className="flex items-center gap-2">
            {onNavigateToRuleBook && (
              <button
                type="button"
                onClick={onNavigateToRuleBook}
                className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-[3px] text-xs font-medium bg-white hover:bg-slate-100 text-slate-700 border border-[#CBD5E1] transition hidden md:inline-flex"
                title="View Rule Book"
              >
                <BookOpen className="w-3.5 h-3.5 text-slate-500" />
                <span>Rule Book</span>
              </button>
            )}

            <button
              type="button"
              onClick={handleCopyShareLink}
              className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-[3px] text-xs font-semibold bg-[#0747A6] hover:bg-[#0052CC] text-white shadow-2xs transition"
              title="Copy direct link to share with managers"
            >
              {copiedLink ? <Check className="w-3.5 h-3.5" /> : <Share2 className="w-3.5 h-3.5" />}
              <span>{copiedLink ? 'Link Copied!' : 'Share Link for Manager'}</span>
            </button>

            <button
              type="button"
              onClick={handlePrint}
              className="cursor-pointer inline-flex items-center gap-1.5 px-3 py-1.5 rounded-[3px] text-xs font-medium bg-white hover:bg-slate-100 text-slate-700 border border-[#CBD5E1] transition hidden sm:inline-flex"
              title="Print or Save as PDF"
            >
              <Printer className="w-3.5 h-3.5 text-slate-500" />
              <span>Print / PDF</span>
            </button>
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="max-w-5xl mx-auto p-4 sm:p-6 lg:p-8 space-y-6">
        {/* Document Header Card */}
        <div className="bg-white border border-[#DFE1E6] rounded-[4px] p-5 sm:p-6 shadow-2xs">
          <div className="flex flex-wrap items-start justify-between gap-4 border-b border-[#EBECF0] pb-4">
            <div>
              <div className="inline-flex items-center gap-1.5 text-xs font-semibold text-red-700 bg-red-50 border border-red-200 px-2 py-0.5 rounded-[3px] mb-2">
                <AlertTriangle className="w-3.5 h-3.5 text-red-600" />
                <span>High Priority Defect Report</span>
              </div>
              <h1 className="text-xl sm:text-2xl font-bold text-slate-900 tracking-tight">
                Notification Deep-Linking &amp; Content Defects
              </h1>
              <p className="text-xs sm:text-sm text-slate-600 mt-1 max-w-2xl">
                Critical QA findings covering broken navigation CTA buttons, missing user parameters, and incomplete security metadata in email notifications.
              </p>
            </div>

            <div className="text-right text-xs text-slate-500 shrink-0">
              <div><strong>Target:</strong> Seedling Notifications</div>
              <div><strong>Environment:</strong> Staging / Production</div>
              <div><strong>Defects Logged:</strong> 5 Issues</div>
            </div>
          </div>

          {/* Quick Metrics Bar */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 pt-4 text-xs">
            <div className="bg-[#F8F9FA] border border-[#E5E7EB] rounded p-2.5">
              <span className="text-slate-500 block text-[11px]">Primary Flow</span>
              <span className="font-semibold text-slate-800">Participation &amp; Identity</span>
            </div>
            <div className="bg-[#F8F9FA] border border-[#E5E7EB] rounded p-2.5">
              <span className="text-slate-500 block text-[11px]">Severity</span>
              <span className="font-semibold text-red-700">P1 - High Priority</span>
            </div>
            <div className="bg-[#F8F9FA] border border-[#E5E7EB] rounded p-2.5">
              <span className="text-slate-500 block text-[11px]">Impact</span>
              <span className="font-semibold text-slate-800">User Flow Blocked</span>
            </div>
            <div className="bg-[#F8F9FA] border border-[#E5E7EB] rounded p-2.5">
              <span className="text-slate-500 block text-[11px]">QA Status</span>
              <span className="font-semibold text-amber-700">Awaiting Dev Fix</span>
            </div>
          </div>
        </div>

        {/* Bug Items List */}
        <div className="space-y-5">
          {bugs.map((bug, index) => (
            <div
              key={bug.id}
              className="bg-white border border-[#DFE1E6] rounded-[4px] overflow-hidden shadow-2xs"
            >
              {/* Card Header */}
              <div className="px-5 py-3.5 bg-white border-b border-[#EBECF0] flex flex-wrap items-center justify-between gap-2">
                <div className="flex items-center gap-2">
                  <span className="font-mono text-xs font-bold text-slate-500">
                    #{index + 1}
                  </span>
                  <span className="text-slate-300">•</span>
                  <span className="font-semibold text-sm sm:text-base text-slate-900">
                    {bug.title}
                  </span>
                </div>

                <div className="flex items-center gap-1.5 text-xs">
                  <span className="font-medium text-slate-600 bg-slate-100 px-2 py-0.5 rounded border border-slate-200">
                    {bug.engine}
                  </span>
                  {bug.ruleId && (
                    <span className="font-mono text-slate-600 bg-slate-100 px-1.5 py-0.5 rounded border border-slate-200">
                      {bug.ruleId}
                    </span>
                  )}
                  <span
                    className={`font-semibold px-2 py-0.5 rounded border ${
                      bug.severity === 'High'
                        ? 'bg-red-50 text-red-700 border-red-200'
                        : 'bg-amber-50 text-amber-700 border-amber-200'
                    }`}
                  >
                    {bug.severity}
                  </span>
                </div>
              </div>

              {/* Card Body */}
              <div className="p-5 space-y-4">
                {/* Description */}
                <p className="text-xs sm:text-sm text-slate-700 leading-relaxed">
                  {bug.description}
                </p>

                {/* Expected vs Actual Comparison Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3 text-xs">
                  <div className="bg-red-50/60 border border-red-200 rounded p-3">
                    <span className="font-bold text-red-800 flex items-center gap-1 mb-1">
                      <AlertTriangle className="w-3.5 h-3.5" />
                      <span>Actual Behavior (Defect)</span>
                    </span>
                    <p className="text-red-950 font-normal leading-relaxed">
                      {bug.actualBehavior}
                    </p>
                  </div>

                  <div className="bg-emerald-50/60 border border-emerald-200 rounded p-3">
                    <span className="font-bold text-emerald-800 flex items-center gap-1 mb-1">
                      <CheckCircle2 className="w-3.5 h-3.5" />
                      <span>Expected Behavior</span>
                    </span>
                    <p className="text-emerald-950 font-normal leading-relaxed">
                      {bug.expectedBehavior}
                    </p>
                  </div>
                </div>

                {/* Screenshot Attachment */}
                {bug.imageSrc && (
                  <div className="pt-2">
                    <span className="text-xs font-semibold text-slate-700 block mb-2">
                      Screenshot Proof:
                    </span>
                    <div className="border border-[#CBD5E1] rounded overflow-hidden max-w-2xl bg-slate-50 relative group">
                      <img
                        src={bug.imageSrc}
                        alt={bug.imageAlt || bug.title}
                        className="w-full object-contain cursor-pointer hover:opacity-95 transition"
                        onClick={() => setActiveImageModal(bug.imageSrc!)}
                        loading="lazy"
                      />
                      <div className="p-2 bg-slate-100 border-t border-[#CBD5E1] text-[11px] text-slate-600 flex items-center justify-between">
                        <span>Click image to view full resolution</span>
                        <button
                          type="button"
                          onClick={() => setActiveImageModal(bug.imageSrc!)}
                          className="text-[#0747A6] font-medium hover:underline cursor-pointer"
                        >
                          Enlarge
                        </button>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>

        {/* Action Items for Engineering */}
        <div className="bg-white border border-[#DFE1E6] rounded-[4px] p-5 sm:p-6 shadow-2xs space-y-3">
          <h2 className="text-base font-bold text-slate-900 border-b border-[#EBECF0] pb-2">
            Action Items &amp; Recommendations for Engineering Team
          </h2>
          <ol className="list-decimal list-inside space-y-2 text-xs sm:text-sm text-slate-700">
            <li>
              <strong>Audit Dynamic Link Variables in Templates:</strong> Verify that call-to-action buttons in templates <code>TPL-CI-PART-041</code> and <code>TPL-ID-025</code> have active href values populated with dynamic deep-link tags (e.g. <code>&#123;&#123;invite_url&#125;&#125;</code> and <code>&#123;&#123;profile_url&#125;&#125;</code>).
            </li>
            <li>
              <strong>Resolve Invitee Name Placeholder:</strong> Fix the missing username variable in template <code>TPL-CI-PART-042</code> to inject the invitee’s display name.
            </li>
            <li>
              <strong>Implement Security Sign-In Metadata:</strong> Update the <em>New Device Detected</em> email layout to display session information (Device Name, Browser/OS, IP Address, Location, Timestamp).
            </li>
            <li>
              <strong>Verify Universal Link Fallbacks:</strong> Ensure web URLs properly redirect to in-app screens on iOS and Android when the native app is installed.
            </li>
          </ol>
        </div>
      </div>

      {/* Lightbox Modal for Full Size Screenshots */}
      {activeImageModal && (
        <div
          className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setActiveImageModal(null)}
        >
          <div
            className="max-w-4xl max-h-[90vh] bg-white rounded p-2 relative shadow-2xl"
            onClick={(e) => e.stopPropagation()}
          >
            <img
              src={activeImageModal}
              alt="Screenshot Preview"
              className="max-w-full max-h-[85vh] object-contain rounded"
            />
            <div className="text-right pt-2">
              <button
                type="button"
                onClick={() => setActiveImageModal(null)}
                className="px-3 py-1 bg-slate-800 text-white text-xs rounded hover:bg-slate-700 cursor-pointer"
              >
                Close (Esc)
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
