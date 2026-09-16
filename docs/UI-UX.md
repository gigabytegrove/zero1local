# Zero1Local UI / UX design system — v1.2.6.1

This document records the owner-facing presentation rules for Zero1Local.

## Branding

- Zero1Local is the appliance-level brand.
- `web/assets/zero1-local-logo-light.png` is the light-appearance asset.
- `web/assets/zero1-local-logo-dark.png` is the dark-appearance asset.
- Supplied artwork is not recolored/redrawn. UI assets remove only source-canvas background/empty margin required for transparent presentation.
- CSS preserves intrinsic aspect ratio and uses `object-fit: contain`; logos must never be cropped.
- Each branding surface renders exactly one theme-selected Zero1Local logo.
- `web/assets/zero1-connect-logo.png` is used only inside the Zero1Connect product context.

## Information architecture

The primary navigation is the canonical way to move among major product areas. Cross-links should exist only when they complete a workflow or resolve an actionable dependency.

Do not create a web of reciprocal “go to…” links between every related area.

Current top-level areas are Home, Files & Sharing, Storage, Sync & Backup, Zero1Connect, Apps, Connectivity, and System.

## Surface hierarchy

1. A page owns its outer padding; nested page containers do not add another page margin.
2. A card/surface represents a distinct concept, not every row or metadata value.
3. Related sections share one surface and use internal separators where practical.
4. Repeated entities use tables/lists/grouped rows rather than floating card stacks.
5. Summary metrics form a single band when they describe one system state.
6. Tables/lists own their chrome; individual rows do not receive independent shadows.
7. Notices are reserved for actionable warnings, errors, or important state—not ordinary explanation text.

## Owner vs. developer information

Normal owner pages must not lead with:

- feature/qualification checks;
- implementation notes;
- raw internal status dumps;
- test evidence;
- developer terminology; or
- repetitive explanatory notices.

When useful for support, this material belongs under **Advanced**, **Feature checks**, **Advanced Stats**, logs, or support diagnostics.

## Density and alignment

- Desktop content can use the owner workspace up to the established 1500px cap.
- Standard page gap: about 14px.
- Standard content-panel padding: about 18px 20px desktop, 16px 14px narrow screens.
- Standard surface radius: about 9–10px.
- Shadows are for overlays/menus/genuinely elevated interactions, not routine information.
- Related actions share a baseline with consistent compact gaps.
- Forms use consistent radius and vertical rhythm.
- Phone Transfer uses an approximately 80/20 desktop split between phones/rules and supporting information.

## Responsive behavior

- Multi-column collections collapse progressively to one column.
- On phone-width screens, grouped collections become one column with appropriate separators.
- Brand artwork scales without distortion.
- No owner workflow may rely on hover-only disclosure.

## Accessibility

- Preserve keyboard focus and semantic controls.
- Decorative logo image nodes use empty alt text while surrounding brand elements carry accessible labels.
- Do not communicate status by color alone.
- Preserve reduced-motion behavior.

## Notification quieting

Recurring advisory notices must expose appropriate suppression controls where presented.

- **Dismiss** suppresses the current notice until restored.
- **Don't remind me again** stores persistent ignored state for that stable notice identity.
- Snoozed notices remain out of attention surfaces until the snooze expires.
- Notifications remains the authoritative place to review/restore suppressed notices.

## Non-removal rule

UI simplification must not silently remove backend capability, routes, safety confirmations, recovery controls, storage operations, or server-side validation. Consolidation changes presentation/ownership; it does not bypass protection.
